-- Small convenience to make a new kernel for the current virtualenv
vim.api.nvim_create_user_command("PythonMakeKernel", function(opts)
  local env_name = opts.args[1]
  if env_name == nil then
    print("Please specify environment name")
    return
  end
  vim.system({ "python", "-m", "pip", "install", "ipykernel" })
  vim.system({
    "python",
    "-m",
    "ipykernel",
    "install",
    "--user",
    "--name",
    env_name,
    "--display-name",
    "Python (" .. env_name .. ")",
  })
end)
