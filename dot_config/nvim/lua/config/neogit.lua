--- Neogit tweaks.
---
--- Upstream Neogit cannot name a stash while it is created, only afterwards
--- (stash popup -> "m" rename). This module patches the stash actions, so the
--- message can be given in one step.
--- See https://github.com/NeogitOrg/neogit/issues/1762
local M = {}

M.opts = {
  --- Ask for a stash message before creating a stash.
  prompt_stash_message = true,
}

--- Ask the user for a stash message.
---@param prompt string|nil
---@return string|nil message nil when the user aborted the input
---@return boolean aborted
function M.ask(prompt)
  prompt = prompt or "Stash message: "

  -- neogit runs the popup actions inside its async context, vim.ui.input is
  -- wrapped, so it can be used with async ui plugins as well
  local async = require("neogit.lib.async")
  local ok, message = pcall(async.wrap(vim.ui.input, 2), { prompt = prompt })

  if not ok then
    -- outside of the async context (tests) fall back to blocking input
    message = vim.fn.input(prompt)
  end

  if message == nil then
    return nil, true
  end

  return message, false
end

--- Patch the neogit stash actions, so a message can be given on creation.
function M.patch()
  if not M.opts.prompt_stash_message then
    return
  end

  local actions = require("neogit.popups.stash.actions")
  local git = require("neogit.lib.git")
  local event = require("neogit.lib.event")

  --- Add the message to the git command, an empty message is skipped.
  ---@param cli table
  ---@param message string
  ---@return table
  local function with_message(cli, message)
    if message == "" then
      return cli
    end

    return cli.message(message)
  end

  --- Stash worktree and index.
  actions.both = function(popup)
    local message, aborted = M.ask()
    if aborted then
      return
    end

    local cli = with_message(git.cli.stash.push.files("."), message)
    local result = cli.arg_list(popup:get_arguments()).call()
    event.send("Stash", { success = result:success() })
  end

  --- Stash the index.
  actions.index = function()
    local message, aborted = M.ask()
    if aborted then
      return
    end

    local cli = with_message(git.cli.stash.push.staged, message)
    local result = cli.call()
    event.send("Stash", { success = result:success() })
  end

  --- Stash the worktree, keep the index.
  actions.keep_index = function()
    local message, aborted = M.ask()
    if aborted then
      return
    end

    local cli = with_message(git.cli.stash.push.keep_index.files("."), message)
    local result = cli.call()
    event.send("Stash", { success = result:success() })
  end
end

---@param opts table|nil
function M.setup(opts)
  M.opts = vim.tbl_extend("force", M.opts, opts or {})
  M.patch()
end

return M
