defmodule Surface.PropertiesTest do
  use ExUnit.Case

  import Surface
  import ComponentTestHelper

  defmodule MapProp do
    use Surface.Component

    property prop, :map

    def render(assigns) do
      ~H"""
      Map?: {{ is_map(@prop) }}
      <span :for={{ {k, v} <- @prop }}>key: {{k}}, value: {{v}}</span>
      """
    end
  end

  defmodule KeywordProp do
    use Surface.Component

    property prop, :keyword

    def render(assigns) do
      ~H"""
      Keyword?: {{ Keyword.keyword?(@prop) }}
      <span :for={{ {k, v} <- @prop }}>key: {{k}}, value: {{v}}</span>
      """
    end
  end

  defmodule CSSClassProp do
    use Surface.Component

    property prop, :css_class

    def render(assigns) do
      ~H"""
      <span class={{ @prop }}/>
      """
    end
  end

  describe "keyword" do
    test "passing a keyword list" do
      code = """
      <KeywordProp prop={{ [option1: 1, option2: 2] }}/>
      """

      assert render_live(code) =~ """
             Keyword?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "passing a keyword list without brackets" do
      code = """
      <KeywordProp prop={{ option1: 1, option2: 2 }}/>
      """

      assert render_live(code) =~ """
             Keyword?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "passing a keyword list as an expression" do
      assigns = %{submit: [option1: 1, option2: 2]}

      code = """
      <KeywordProp prop={{ @submit }}/>
      """

      assert render_live(code, assigns) =~ """
             Keyword?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "validate invalid values" do
      code = """
      <KeywordProp prop={{ 1 }}/>
      """

      message = "invalid value for property \"prop\". Expected a :keyword, got: 1"

      assert_raise(RuntimeError, message, fn ->
        render_live(code)
      end)
    end
  end

  describe "map" do
    test "passing a map" do
      code = """
      <MapProp prop={{ %{option1: 1, option2: 2} }}/>
      """

      assert render_live(code) =~ """
             Map?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "passing a keyword list" do
      code = """
      <MapProp prop={{ [option1: 1, option2: 2] }}/>
      """

      assert render_live(code) =~ """
             Map?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "passing a keyword list without brackets" do
      code = """
      <MapProp prop={{ option1: 1, option2: 2 }}/>
      """

      assert render_live(code) =~ """
             Map?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "passing a map as an expression" do
      assigns = %{submit: %{option1: 1, option2: 2}}

      code = """
      <MapProp prop={{ @submit }}/>
      """

      assert render_live(code, assigns) =~ """
             Map?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "passing a keyword list as an expression" do
      assigns = %{submit: [option1: 1, option2: 2]}

      code = """
      <MapProp prop={{ @submit }}/>
      """

      assert render_live(code, assigns) =~ """
             Map?: true
             <span>key: option1, value: 1</span>\
             <span>key: option2, value: 2</span>
             """
    end

    test "validate invalid values" do
      code = """
      <MapProp prop={{ 1 }}/>
      """

      message = "invalid value for property \"prop\". Expected a :map, got: 1"

      assert_raise(RuntimeError, message, fn ->
        render_live(code)
      end)
    end
  end

  describe "css_class" do
    test "passing a string" do
      code = """
      <CSSClassProp prop="class1 class2"/>
      """

      assert render_live(code) =~ """
             <span class="class1 class2"></span>
             """
    end

    test "passing a keywod list" do
      code = """
      <CSSClassProp prop={{ [class1: true, class2: false, class3: true] }}/>
      """

      assert render_live(code) =~ """
             <span class="class1 class3"></span>
             """
    end

    test "passing a keywod list without brackets" do
      code = """
      <CSSClassProp prop={{ class1: true, class2: false, class3: true }}/>
      """

      assert render_live(code) =~ """
             <span class="class1 class3"></span>
             """
    end
  end
end
