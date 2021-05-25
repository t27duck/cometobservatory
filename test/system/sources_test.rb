require "application_system_test_case"

class SourcesTest < ApplicationSystemTestCase
  setup do
    @source = sources(:one)
  end

  test "visiting the index" do
    visit sources_url
    assert_selector "h1", text: "Sources"
  end

  test "creating a Source" do
    visit sources_url
    click_on "New Source"

    fill_in "Image filename", with: @source.image_filename
    fill_in "Name", with: @source.name
    fill_in "Source class", with: @source.source_class
    fill_in "Url", with: @source.url
    click_on "Create Source"

    assert_text "Source was successfully created"
    click_on "Back"
  end

  test "updating a Source" do
    visit sources_url
    click_on "Edit", match: :first

    fill_in "Image filename", with: @source.image_filename
    fill_in "Name", with: @source.name
    fill_in "Source class", with: @source.source_class
    fill_in "Url", with: @source.url
    click_on "Update Source"

    assert_text "Source was successfully updated"
    click_on "Back"
  end

  test "destroying a Source" do
    visit sources_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Source was successfully destroyed"
  end
end
