require 'minitest/autorun'
require 'oxford/face/api'

KEY=File.open("./test/key.txt", "r").readline().strip

class ApiTest < Minitest::Test
  def test_detect
	OxfordFaceApi.init(KEY)

	f = OxfordFaceApi::Face.new

	img_url = "https://raw.githubusercontent.com/tantara/oxford-face-api/master/test/example.jpg"
	return_face_id = true
	return_face_landmarks = false
	return_face_attributes = "age,gender"
	res = f.detect(img_url, return_face_id, return_face_landmarks, return_face_attributes)
	puts res.body # => https://gist.github.com/tantara/5d72786bd3c6acc285a29ec44c4a8d1e

	assert_equal "hello world",
	  "hello world"
  end
end

=begin
KEY="YOUR_KEY" # FIXME

OxfordFaceApi.init(KEY)
#puts OxfordFaceApi.API_KEY

f = OxfordFaceApi::Face.new
fl = OxfordFaceApi::FaceList.new
p = OxfordFaceApi::Person.new
pg = OxfordFaceApi::PersonGroup.new

# create person group
group_id = "oxford-dev"
group_name = "group-oxford-dev"
#res = pg.create(group_id, group_name)
#puts res.body # ""

# add person to person group
person_name = "person-tantara"
person_user_data = "developer"
#res = p.create(group_id, person_name, person_user_data)
#puts res.body # {"personId":"3a9a24c9-9ece-4e6b-b511-84a19131496b"} 1311f360-e822-41f7-804b-d2442e827588

# add face to person
person_id = "3a9a24c9-9ece-4e6b-b511-84a19131496b"
img_url = "http://path/img.jpg"
#res = p.add_face(group_id, person_id, img_url)
#puts res.body # {"persistedFaceId":"e98c6f3f-b772-4836-8f73-6661ab32fbe2"} # 56e8afa6-7880-4ed9-9caf-772df773a845

# get person information
#res = p.get(group_id, person_id)
#puts res.body
# {"personId":"3a9a24c9-9ece-4e6b-b511-84a19131496b","persistedFaceIds":["e98c6f3f-b772-4836-8f73-6661ab32fbe2"],"name":"person-tantara","userData":"developer"}

# detect face
img_url = "http://path/img.jpg"
return_face_id = true # default: true
return_face_landmarks = false # default: false
return_face_attributes = ""#age,gender" # default: ""
res = f.detect(img_url, return_face_id, return_face_landmarks, return_face_attributes)
puts res.body # https://gist.github.com/tantara/932202b63c5d2008af1b138d73383931

face_id = "8ffe65f0-e174-4d57-a6ff-c3570221306c" # face_id from https://gist.github.com/tantara/932202b63c5d2008af1b138d73383931
face_ids = [
  face_id
]
#res = f.identify(group_id, face_ids)
#puts res.body # type1: not trained, type2: normal

# type1: not trained
# {"error":{"code":"PersonGroupNotTrained","message":"Person group 'oxford-dev' not trained."}}
# if you get a error message like above
# you need to train the person group
#res = pg.train(group_id)
#puts res.body # ""

# type2: normal
#[{"faceId":"8ffe65f0-e174-4d57-a6ff-c3570221306c","candidates":[{"personId":"3a9a24c9-9ece-4e6b-b511-84a19131496b","confidence":1.0}]}]

# get group's training status
#res = pg.status(group_id)
#puts res.body # {"status":"succeeded","createdDateTime":"10/15/2016 3:20:34 PM","lastActionDateTime":"10/15/2016 3:20:36 PM","message":null}

# get all person groups
#res = pg.all
#puts res.body # [{"personGroupId":"oxford-dev","name":"group-oxford-dev","userData":null},{"personGroupId":"tester","name":"group1","userData":"user-provided data attached to the person group"}]

# update group's information
new_group_name = "group-oxford-dev-updated"
new_group_user_data = "A to Z"
#res = pg.update(group_id, new_group_name, new_group_user_data)
#puts res.body # ""

# get group information
#res = pg.get(group_id)
#puts res.body # {"personGroupId":"oxford-dev","name":"group-oxford-dev-updated","userData":"A to Z"}

####################
### ADDITIONAL
####################

# verify1
face_id1 = "" #FIXME
face_id2 = "" #FIXME
#res = f.verify(face_id1, face_id2)
#puts res.body # {"isIdentical":true, "confidence":0.9}

# verify2
#res = f.verify(face_id, group_id, person_id)
#puts res.body # {"isIdentical":true,"confidence":1.0}

#  update person information
new_person_name = "new-person-tantara"
new_person_user_data = "new developer"
#res = p.update(group_id, person_id, new_person_name, new_person_user_data)
#puts res.body # ""

# get all person in group
#res = p.all(group_id)
#puts res.body # [{"personId":"3a9a24c9-9ece-4e6b-b511-84a19131496b","persistedFaceIds":["e98c6f3f-b772-4836-8f73-6661ab32fbe2"],"name":"new-person-tantara","userData":"new developer"}]

# update person face information
face_id_in_group = "e98c6f3f-b772-4836-8f73-6661ab32fbe2"
new_face_user_data = "update face information"
#res = p.update_face(group_id, person_id, face_id_in_group, new_face_user_data)
#puts res.body # ""

# get person's face
#res = p.face(group_id, person_id, face_id_in_group)
#puts res.body # {"persistedFaceId":"e98c6f3f-b772-4836-8f73-6661ab32fbe2","userData":"update face information"}

# create facelist
face_list_id = "oxford-dev"
face_list_name = "facelist-oxford-dev"
#res = fl.create(face_list_id, face_list_name)
#puts res.body # ""

# get all facelist
#res = fl.all
#puts res.body # [{"faceListId":"oxford-dev","name":"facelist-oxford-dev","userData":null}]

# add face to face list
#res = fl.add_face(face_list_id, img_url)
#puts res.body # {"persistedFaceId":"6828c0c6-49ce-4409-975a-e95430067eca"}

# get all face from facelist
#res = fl.faces(face_list_id)
#puts res.body # {"persistedFaces":[{"persistedFaceId":"6828c0c6-49ce-4409-975a-e95430067eca","userData":null}],"faceListId":"oxford-dev","name":"facelist-oxford-dev","userData":null}

# update facelist
new_face_list_name = "new-facelist-oxford-dev"
new_face_list_user_data = "update facelist information"
#res = fl.update(face_list_id, new_face_list_name, new_face_list_user_data)
#puts res.body # ""
=end
