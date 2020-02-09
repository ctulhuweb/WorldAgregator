namespace :parser do
  task parse_new_items: :environment do
    Parser.get_data_for_all_sites(Site.active.all)
  end
end
