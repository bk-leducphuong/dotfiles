-- Java & Spring Boot support via nvim-jdtls
-- This integrates with Mason's jdtls installation.

return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		-- Only run for Java buffers
		local ok, jdtls = pcall(require, "jdtls")
		if not ok then
			return
		end

		-- Mason jdtls installation path
		local mason_registry = require("mason-registry")
		local jdtls_pkg = mason_registry.get_package("jdtls")
		local jdtls_path = jdtls_pkg:get_install_path()

		local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
		local config_dir = jdtls_path .. "/config_linux" -- You are on Linux

		-- Workspace directory per project
		local workspace_dir = vim.fn.stdpath("data")
			.. "/jdtls-workspace/"
			.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

		-- Root dir (Maven/Gradle/Spring Boot projects)
		local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }
		local root_dir = require("jdtls.setup").find_root(root_markers)
		if not root_dir or root_dir == "" then
			return
		end

		local cmd = {
			"java", -- Uses system java (JDK) from PATH
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xms1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-jar",
			launcher_jar,
			"-configuration",
			config_dir,
			"-data",
			workspace_dir,
		}

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			-- Use your global LSP mappings plus Java-specific extras
			local opts = { buffer = bufnr, silent = true, noremap = true }

			-- Organize imports & code actions
			vim.keymap.set("n", "<leader>jo", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Java Organize Imports" }))
			vim.keymap.set("n", "<leader>jv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Java Extract Variable" }))
			vim.keymap.set("v", "<leader>jv", function()
				jdtls.extract_variable(true)
			end, vim.tbl_extend("force", opts, { desc = "Java Extract Variable" }))
			vim.keymap.set("v", "<leader>jm", function()
				jdtls.extract_method(true)
			end, vim.tbl_extend("force", opts, { desc = "Java Extract Method" }))

			-- Test support (JUnit, Spring Boot tests)
			vim.keymap.set("n", "<leader>jt", jdtls.test_nearest_method, vim.tbl_extend("force", opts, { desc = "Java Test Nearest" }))
			vim.keymap.set("n", "<leader>jT", jdtls.test_class, vim.tbl_extend("force", opts, { desc = "Java Test Class" }))
		end

		local config = {
			cmd = cmd,
			root_dir = root_dir,
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				java = {
					-- Basic Spring Boot friendliness (use default JDK)
					configuration = {
						updateBuildConfiguration = "interactive",
					},
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"org.junit.jupiter.api.Assumptions.*",
						},
					},
					contentProvider = { preferred = "fernflower" },
					references = {
						includeDecompiledSources = true,
					},
					format = {
						enabled = true,
					},
				},
			},
		}

		-- Start or attach jdtls when editing Java files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				jdtls.start_or_attach(config)
			end,
		})
	end,
}

