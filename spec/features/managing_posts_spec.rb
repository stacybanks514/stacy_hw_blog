require 'rails_helper'

def create_posts
  Post.create!(
    subject: 'Test Post',
    body: 'This is a test',
    published_at: '2014-10-20 13:01:00 UTC'
  )
end


feature "Manage Post" do
  scenario "visit the index and see that blogs are or aren't there" do
    visit posts_path

    expect(page.find('.noposts')).to have_content(/No Posts available/i)
  end

  scenario "List all Posts" do
    create_posts

    visit posts_path

    expect(page.find('.subject')).to have_content(/Test Post/)
    expect(page.find('.body')).to have_content(/This is a test/)
    expect(page.find('.published_at')).to have_content(/2014-10-20 13:01:00 UTC/)
    expect(page).not_to have_content(/No Posts available/i)
  end

  scenario "click the create new button and be directed to a new page with a form" do
    visit posts_path
    click_on 'New Post'

    expect(current_path).to eq(new_post_path)
  end

  scenario "enter input on the form and click submit, be redirected and then see the new post on the index page" do
    visit new_post_path
    fill_in 'Subject', with: 'Test Post'
    fill_in 'Body', with: 'This is a test'
    fill_in 'Published at', with: '2014-10-20 13:01:00 UTC'
    click_on 'Create Post'

    expect(current_path).to eq(post_path(Post.last))

    click_on 'Back'

    expect(current_path).to eq(posts_path)
  end

  scenario "edit a particular post, be redirected and see the updated post on the index page." do
    new_post = create_posts

    visit edit_post_path(new_post)
    fill_in 'Subject', with: 'New Test'
    fill_in 'Body', with: 'This is a new test'
    click_on 'Update Post'

    expect(current_path).to eq(post_path(Post.last))

    click_on 'Back'

    expect(current_path).to eq(posts_path)
  end

  #   scenario "Show an Album" do
  #     album = create_astrolounge

  #     visit album_path(album)

  #     expect(current_path).to eq(album_path(album))
  #   end

  scenario "delete a post, be redirected to the index page and expect NOT to see the deleted post anymore" do
    create_posts

    visit posts_path
    click_on 'Destroy'

    # expect(find('.notice')).to have_content(/sure/i)
    # click_on "OK"
    # visit albums_path
    # click_on 'Remove'

    expect(current_path).to eq(posts_path)
    expect(posts_path).to_not have_content(/Test Post/)
  end
end
