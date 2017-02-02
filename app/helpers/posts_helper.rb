module PostsHelper
  def voted_for(post)
    v_count = votes_count_for(post)
    return if v_count.zero?
    return "#{v_count} likes" if v_count > 2
    voters_table_for(post).to_sentence.html_safe +
      (v_count == 1 ? ' likes' : ' like') +
      ' this.'
  end

  def votes_count_for(post)
    post.votes_for.up.by_type('User').voters.count
  end

  private

  def voters_table_for(post)
    post.votes_for.up.by_type('User').voters.map do |v|
      link_to v.name, profile_path(v.name)
    end
  end
end
