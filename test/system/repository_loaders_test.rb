require "application_system_test_case"

class RepositoryLoadersTest < ApplicationSystemTestCase
  setup do
    @repository_loader = repository_loaders(:one)
  end

  test "visiting the index" do
    visit repository_loaders_url
    assert_selector "h1", text: "Repository Loaders"
  end

  test "creating a Repository loader" do
    visit repository_loaders_url
    click_on "New Repository Loader"

    fill_in "Repository list", with: @repository_loader.repository_list
    click_on "Create Repository loader"

    assert_text "Repository loader was successfully created"
    click_on "Back"
  end

  test "updating a Repository loader" do
    visit repository_loaders_url
    click_on "Edit", match: :first

    fill_in "Repository list", with: @repository_loader.repository_list
    click_on "Update Repository loader"

    assert_text "Repository loader was successfully updated"
    click_on "Back"
  end

  test "destroying a Repository loader" do
    visit repository_loaders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Repository loader was successfully destroyed"
  end
end
