require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template "static_pages/home"
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", products_path
  end

  test "one nav link should be active" do
    get root_path
    assert_select "ul.nav" do
      assert_select "li.active", 1
    end

    get products_path
    assert_select "ul.nav" do
      assert_select "li.active", 1
    end
  end

end
