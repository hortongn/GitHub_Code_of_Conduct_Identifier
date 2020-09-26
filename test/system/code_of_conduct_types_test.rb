require "application_system_test_case"

class CodeOfConductTypesTest < ApplicationSystemTestCase
  setup do
    @code_of_conduct_type = code_of_conduct_types(:one)
  end

  test "visiting the index" do
    visit code_of_conduct_types_url
    assert_selector "h1", text: "Code Of Conduct Types"
  end

  test "creating a Code of conduct type" do
    visit code_of_conduct_types_url
    click_on "New Code Of Conduct Type"

    fill_in "Name", with: @code_of_conduct_type.name
    fill_in "Url", with: @code_of_conduct_type.url
    click_on "Create Code of conduct type"

    assert_text "Code of conduct type was successfully created"
    click_on "Back"
  end

  test "updating a Code of conduct type" do
    visit code_of_conduct_types_url
    click_on "Edit", match: :first

    fill_in "Name", with: @code_of_conduct_type.name
    fill_in "Url", with: @code_of_conduct_type.url
    click_on "Update Code of conduct type"

    assert_text "Code of conduct type was successfully updated"
    click_on "Back"
  end

  test "destroying a Code of conduct type" do
    visit code_of_conduct_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Code of conduct type was successfully destroyed"
  end
end
