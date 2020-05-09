local wibox      = require ("wibox")

local wibox_utils = {}

local function margin (tab, widget)
  if tab.left ~= nil or tab.right ~= nil then
    return wibox.container.margin (
      widget,
      tab.left or 0,
      tab.right or 0
    )
  else
    return widget
  end
end

local function background (tab, widget)
  if tab.color ~= nil then
    return wibox.container.background (
      widget,
      tab.color
    )
  else
    return widget
  end
end


function wibox_utils.gen_widget_bar (tab)
  -- Set the layout
  local widgets = {layout = wibox.layout.fixed.horizontal}

  -- Set the left separator if applicable
  if tab.left_sep then
    widgets[#widgets+1] = tab.separator (
      "alpha",
      tab.widgets[1].color or "alpha"
    )
  end

  for k, v in pairs (tab.widgets) do

    widgets[#widgets+1] = background (v, margin (v, v.widget))

    if k < #tab.widgets then
      widgets[#widgets+1] = tab.separator (
        v.color or "alpha",
        tab.widgets[k+1].color or "alpha"
      )
    end

  end
  if tab.right_sep then
    widgets[#widgets+1] = tab.separator (
      tab.widgets[#tab.widgets].color or "alpha",
      "alpha"
    )
  end

  return widgets
end

return wibox_utils
