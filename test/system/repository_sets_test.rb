require "application_system_test_case"

class RepositorySetsTest < ApplicationSystemTestCase
  setup do
    @repository_set = repository_sets(:one)
  end

  test "visiting the index" do
    visit repository_sets_url
    assert_selector "h1", text: "Repository Sets"
  end

  test "creating a Repository set" do
    visit repository_sets_url
    click_on "New Repository Set"

    fill_in "Name", with: @repository_set.name
    click_on "Create Repository set"

    assert_text "Repository set was successfully created"
    click_on "Back"
  end

  test "updating a Repository set" do
    visit repository_sets_url
    click_on "Edit", match: :first

    fill_in "Name", with: @repository_set.name
    click_on "Update Repository set"

    assert_text "Repository set was successfully updated"
    click_on "Back"
  end

  test "destroying a Repository set" do
    visit repository_sets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Repository set was successfully destroyed"
  end
end
