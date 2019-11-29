# frozen_string_literal: true

RSpec.describe Post, type: :model do
  it 'validates empty post' do
    post = FactoryBot.build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to include("can't be blank")
  end

  it 'validates content length maximum 100 words' do
    post = FactoryBot.build(:post, content: 'The color a woman chooses
      for her hair 
      says a lot about her, unless of course, she doesn’t 
      color it at all, in which
      case she is in an entirely separate category of women
         who don’t color their hair 
      about which one can assume something completely different.

      Most women dye their hair blond, which communicates 
      outgoingness, or at least the
      desire to be outgoing, and pretty, of course. 
      Dyed red hair communicates rebellion 
      and the desire to be viewed as a challenge.

      But she dyed her hair jet black and hoped 
      to communicate nothing but the 
      unwillingness to reveal anything. today')
    post.valid?
    expect(post.errors[:content]).to include('is too long (maximum is 100 characters)')
  end
end
