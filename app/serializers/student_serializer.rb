class StudentSerializer < ActiveModel::Serializer

  attributes  :id,
              :username,
              :first_name,
              :last_name,
              :institution
end
