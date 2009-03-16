Factory.define :user do |u|
  u.login "rsmith + #{rand(3000).to_s}"
  u.max_personal 5.0
  u.max_etc 5.0
  u.max_vacation 5.0
end