namespace :db do
  task create_permissions: :environment do
    arr = []
    controllers = Dir.new("#{Rails.root}/app/controllers/admin").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        arr << entry.camelize.gsub(".rb", "").prepend("Admin::").constantize
      end
    end

    except_arr = Settings.permission.except
    arr.each do |controller|
      unless except_arr.include? controller.permission
        create_permission controller.permission
      end
    end
  end
end

def create_permission model
  permission = Permission.find_by subject_class: model
  Permission.create subject_class: model unless permission
end
