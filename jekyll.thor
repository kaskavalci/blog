require "stringex"
require "date"

class Jekyll < Thor
  desc "new", "create a new post"
  method_option :editor, :default => "cursor", :desc => "Editor to open the file with"
  method_option :date, :default => Date.today.strftime('%Y-%m-%d'), :desc => "Date for the post (YYYY-MM-DD format)"
  method_option :layout, :default => "single", :desc => "Layout to use for the post"
  method_option :tags, :type => :array, :default => [], :desc => "Tags for the post"
  method_option :draft, :type => :boolean, :default => false, :desc => "Create as draft in _drafts folder"

  def new(*title)
    if title.empty?
      puts "Error: Please provide a title for the post"
      puts "Usage: thor jekyll:new 'Your Post Title'"
      exit 1
    end

    title_text = title.join(" ")
    date = options[:date]
    layout = options[:layout]
    tags = options[:tags]
    is_draft = options[:draft]

    # Validate date format
    unless date.match?(/^\d{4}-\d{2}-\d{2}$/)
      puts "Error: Invalid date format. Use YYYY-MM-DD"
      exit 1
    end

    # Determine folder and filename
    folder = is_draft ? "_drafts" : "_posts"
    filename = "#{folder}/#{date}-#{title_text.to_url}.md"

    # Create _drafts folder if it doesn't exist and we're creating a draft
    if is_draft && !Dir.exist?("_drafts")
      Dir.mkdir("_drafts")
      puts "Created _drafts folder"
    end

    if File.exist?(filename)
      puts "Warning: #{filename} already exists!"
      puts "Would you like to create with a different name? (y/n)"
      response = STDIN.gets.chomp.downcase
      if response == 'y'
        filename = "#{folder}/#{date}-#{title_text.to_url}-#{Time.now.to_i}.md"
      else
        puts "Post creation cancelled."
        exit 0
      end
    end

    puts "Creating new #{is_draft ? 'draft' : 'post'}: #{filename}"

    # Create the post content
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: #{layout}"
      post.puts "title: \"#{title_text.gsub(/&/,'&amp;')}\""
      post.puts "date: #{date}"
      post.puts "tags:"
      if tags.empty?
        post.puts " -"
      else
        tags.each { |tag| post.puts " - #{tag}" }
      end
      post.puts "categories:"
      post.puts " -"
      post.puts "---"
      post.puts ""
      post.puts "#{title_text}"
      post.puts ""
      post.puts "<!-- Add your content here -->"
      post.puts ""
      post.puts "## Introduction"
      post.puts ""
      post.puts "<!-- Write your introduction here -->"
      post.puts ""
      post.puts "## Main Content"
      post.puts ""
      post.puts "<!-- Write your main content here -->"
      post.puts ""
      post.puts "## Conclusion"
      post.puts ""
      post.puts "<!-- Write your conclusion here -->"
    end

    puts "Post created successfully!"
    puts "Opening with #{options[:editor]}..."

    # Try to open with the specified editor
    if system(options[:editor], filename)
      puts "Editor opened successfully!"
    else
      puts "Warning: Could not open with #{options[:editor]}"
      puts "You can manually open: #{filename}"
    end
  end

  desc "draft", "create a new draft post"
  method_option :editor, :default => "cursor", :desc => "Editor to open the file with"
  method_option :date, :default => Date.today.strftime('%Y-%m-%d'), :desc => "Date for the post (YYYY-MM-DD format)"
  method_option :layout, :default => "single", :desc => "Layout to use for the post"
  method_option :tags, :type => :array, :default => [], :desc => "Tags for the post"

  def draft(*title)
    options[:draft] = true
    new(*title)
  end

  desc "publish", "publish a draft by moving it to _posts"
  method_option :date, :default => Date.today.strftime('%Y-%m-%d'), :desc => "Date for the published post (YYYY-MM-DD format)"

  def publish(draft_name)
    draft_path = "_drafts/#{draft_name}"

    unless File.exist?(draft_path)
      puts "Error: Draft '#{draft_name}' not found in _drafts folder"
      puts "Available drafts:"
      Dir.glob("_drafts/*.md").each { |f| puts "  - #{File.basename(f)}" }
      exit 1
    end

    date = options[:date]
    new_filename = "_posts/#{date}-#{draft_name}"

    if File.exist?(new_filename)
      puts "Error: A post with that name already exists in _posts"
      exit 1
    end

    File.rename(draft_path, new_filename)
    puts "Draft '#{draft_name}' published as '#{new_filename}'"
  end

  desc "list", "list all posts and drafts"

  def list
    puts "Posts:"
    puts "------"
    Dir.glob("_posts/*.md").sort.reverse.each do |file|
      date = File.basename(file)[0..9]
      title = File.basename(file)[11..-4].gsub('-', ' ').capitalize
      puts "#{date} - #{title}"
    end

    if Dir.exist?("_drafts")
      puts "\nDrafts:"
      puts "-------"
      Dir.glob("_drafts/*.md").each do |file|
        title = File.basename(file)[0..-4].gsub('-', ' ').capitalize
        puts "- #{title}"
      end
    end
  end
end
