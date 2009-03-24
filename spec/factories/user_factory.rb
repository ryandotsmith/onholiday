Factory.define :user do |u|
  u.login "rsmith#{rand(3000).to_s}"
  u.max_personal 10.0
  u.max_etc 10.0
  u.max_vacation 10.0
end