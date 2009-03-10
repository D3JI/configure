module ShopsHelper
  module ActionView
    module Helpers
      module FormOptionsHelper
        def option_groups_from_collection_for_select(collection, group_method, group_label_method, option_key_method, option_value_method, selected_key = nil)
          collection.inject("") do |options_for_select, group|
            group_label_string = eval("group.#{group_label_method}")
            if group.send(group_method).blank?
              options_for_select += options_for_select(group.send(option_value_method) => group.send(option_key_method))
            else
              options_for_select += ""
            end
          end
        end
      end
    end
  end
end
