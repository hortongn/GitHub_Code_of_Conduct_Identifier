require "application_system_test_case"

class CodeOfConductsTest < ApplicationSystemTestCase
  setup do
    @code_of_conduct = code_of_conducts(:one)
  end

  test "visiting the index" do
    visit code_of_conducts_url
    assert_selector "h1", text: "Code Of Conducts"
  end

  test "creating a Code of conduct" do
    visit code_of_conducts_url
    click_on "New Code Of Conduct"

    fill_in "Path", with: @code_of_conduct.path
    fill_in "Repository", with: @code_of_conduct.repository_id
    click_on "Create Code of conduct"

    assert_text "Code of conduct was successfully created"
    click_on "Back"
  end

  test "updating a Code of conduct" do
    visit code_of_conducts_url
    click_on "Edit", match: :first

    fill_in "Path", with: @code_of_conduct.path
    fill_in "Repository", with: @code_of_conduct.repository_id
    click_on "Update Code of conduct"

    assert_text "Code of conduct was successfully updated"
    click_on "Back"
  end

  test "destroying a Code of conduct" do
    visit code_of_conducts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Code of conduct was successfully destroyed"
  end
end
