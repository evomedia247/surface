defmodule Surface.Components.Form.DateTimeLocalInput do
  @moduledoc """
  Generates a color input.

  Provides a wrapper for Phoenix.HTML.Form's `datetime_local_input/3` function.

  All options passed via `opts` will be sent to `datetime_local_input/3`, `value` and
  `class` can be set directly and will override anything in `opts`.


  ## Examples

  ```
  <DateTimeLocalInput form="order" field="completed_at" opts={{ autofocus: "autofocus" }} />
  ```
  """

  use Surface.Components.Form.Input

  import Phoenix.HTML.Form, only: [datetime_local_input: 3]
  import Surface.Components.Form.Utils

  context get form, from: Form, as: :form_context

  def render(assigns) do
    form = get_form(assigns)
    props = get_non_nil_props(assigns, [:value, :class])
    event_opts = get_events_to_opts(assigns)

    ~H"""
    {{
      datetime_local_input(
        form,
        String.to_atom(@field),
        props ++ @opts ++ event_opts
      )
    }}
    """
  end
end
