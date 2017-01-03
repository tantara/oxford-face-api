require "oxford/face/api/version"
require "oxford/face/http_client"

module OxfordFaceApi
  @api_key = ""

  def self.init(api_key)
	@api_key = api_key
  end

  def self.API_KEY
	@api_key
  end

  class Face
	def initialize
	  raise if OxfordFaceApi.API_KEY.empty?
	  @client = HttpClient.new(OxfordFaceApi.API_KEY, true)
	end

	# Detect
	# POST https://api.projectoxford.ai/face/v1.0/detect[?returnFaceId][&returnFaceLandmarks][&returnFaceAttributes]
	def detect(url, return_face_id = true, return_face_landmarks = false, return_face_attributes = "")
	  params = {
		url: url
	  }
	  @client.post("/detect?returnFaceId=#{return_face_id}&returnFaceLandmarks=#{return_face_landmarks}&returnFaceAttributes=#{return_face_attributes}", params)
	end

	# TODO
	# Find Similar
	# POST https://api.projectoxford.ai/face/v1.0/findsimilars
	def find_similar
	  params = {
	  }
	  @client.post("/findsimilars", params)
	end

	# TODO
	# Group
	# POST https://api.projectoxford.ai/face/v1.0/group
	def group
	  params = {
	  }
	  @client.post("/group", params)
	end

	# Identify
	# POST https://api.projectoxford.ai/face/v1.0/identify
	def identify(group_id, face_ids, max_num_of_candidates_returned = 1, confidence_threshold = 0.5)
	  params = {
		faceIds: face_ids,
		personGroupId: group_id, 
		maxNumOfCandidatesReturned: max_num_of_candidates_returned,
		confidenceThreshold: confidence_threshold
	  }
	  @client.post("/identify", params)
	end

	# Verify
	# POST https://api.projectoxford.ai/face/v1.0/verify
	def verify(face_id, group_id, person_id = "")
	  if person_id.empty?
		face_id1 = face_id
		face_id2 = group_id

		params = {
		  faceId1: face_id1,
		  faceId2: face_id2,
		}
	  else
		params = {
		  faceId: face_id,
		  personGroupId: group_id,
		  personId: person_id
		}
	  end
	  @client.post("/verify", params)
	end
  end

  class FaceList
	def initialize
	  raise if OxfordFaceApi.API_KEY.empty?
	  @client = HttpClient.new(OxfordFaceApi.API_KEY)
	end

	# Add a Face to a Face List
	# POST https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}/persistedFaces[?userData][&targetFace]
	def add_face(face_list_id, url, user_data = "", target_face = "")
	  params = {
		url: url
	  }
	  @client.post("/facelists/#{face_list_id}/persistedFaces?userData=#{user_data}&targetFace=#{target_face}", params)
	end

	# Create a Face List
	# PUT https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
	def create(face_list_id, name, user_data = "")
	  params = {
		name: name,
		userData: user_data
	  }
	  @client.put("/facelists/#{face_list_id}", params)
	end

	# FIXME
	# Delete a Face from a Face List
	# DELETE https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}/persistedFaces/{persistedFaceId}
	def delete_face(face_list_id, face_id)
	  @client.delete("/facelists/#{face_list_id}/persistedFaces/#{face_id}")
	end

	# FIXME
	# Delete a Face List
	# DELETE https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
	def delete(face_list_id)
	  @client.delete("/facelists/#{face_list_id}")
	end

	# Get a Face List
	# GET https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
	def faces(face_list_id)
	  @client.get("/facelists/#{face_list_id}")
	end

	# List Face Lists
	# GET https://api.projectoxford.ai/face/v1.0/facelists
	def all
	  @client.get("/facelists")
	end

	# Update a Face List
	# PATCH https://api.projectoxford.ai/face/v1.0/facelists/{faceListId}
	def update(face_list_id, name, user_data)
	  params = {
		name: name,
		userData: user_data
	  }
	  @client.patch("/facelists/#{face_list_id}", params)
	end
  end

  class Person
	def initialize
	  raise if OxfordFaceApi.API_KEY.empty?
	  @client = HttpClient.new(OxfordFaceApi.API_KEY)
	end

	# Add a Person Face
	# POST https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces[?userData][&targetFace]
	def add_face(group_id, person_id, url, user_data = "", target_face = "")
	  params = {
		url: url
	  }
	  @client.post("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces?userData=#{user_data}&targetFace=#{target_face}", params)
	end

	# Create a Person
	# POST https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons
	def create(group_id, name, user_data = "")
	  params = {
		name: name,
		userData: user_data
	  }
	  @client.post("/persongroups/#{group_id}/persons", params)
	end

	# FIXME
	# Delete a Person
	# DELETE https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}
	def delete(group_id, person_id)
	  @client.delete("/persongroups/#{group_id}/persons/#{person_id}")
	end

	# FIXME
	# Delete a Person Face
	# DELETE https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces/{persistedFaceId}
	def delete_face(group_id, person_id, face_id)
	  @client.delete("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces/#{face_id}")
	end

	# Get a Person
	# GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}
	def get(group_id, person_id)
	  @client.get("/persongroups/#{group_id}/persons/#{person_id}")
	end

	# Get a Person Face
	# GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces/{persistedFaceId}
	def face(group_id, person_id, face_id)
	  @client.get("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces/#{face_id}")
	end

	# List Persons in a Person Group
	# GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons
	def all(group_id)
	  @client.get("/persongroups/#{group_id}/persons")
	end

	# Update a Person
	# PATCH https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}
	def update(group_id, person_id, name, user_data)
	  params = {
		name: name,
		userData: user_data
	  }
	  @client.patch("/persongroups/#{group_id}/persons/#{person_id}", params)
	end

	# Update a Person Face
	# PATCH ttps://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/persons/{personId}/persistedFaces/{persistedFaceId}
	def update_face(group_id, person_id, face_id, user_data)
	  params = {
		userData: user_data
	  }
	  @client.patch("/persongroups/#{group_id}/persons/#{person_id}/persistedFaces/#{face_id}", params)
	end
  end

  class PersonGroup
	def initialize
	  raise if OxfordFaceApi.API_KEY.empty?
	  @client = HttpClient.new(OxfordFaceApi.API_KEY)
	end

	# Create a Person Group
	# PUT https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
	def create(group_id, name, user_data = "")
	  params = {
		name: name,
		userData: user_data
	  }
	  @client.put("/persongroups/#{group_id}", params)
	end

	# FIXME
	# Delete a Person Group
	# DELETE https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
	def delete(group_id)
	  @client.delete("/persongroups/#{group_id}")
	end

	# Get a Person Group
	# GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
	def get(group_id)
	  @client.get("/persongroups/#{group_id}")
	end

	# Get Person Group Training Status
	# GET https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/training
	def status(group_id)
	  @client.get("/persongroups/#{group_id}/training")
	end

	# List Person Groups
	# GET https://api.projectoxford.ai/face/v1.0/persongroups[?start][&top]
	def all(start = 1, top = 1000)
	  @client.get("/persongroups?start=#{start}&top=#{top}")
	end

	# Train Person Group
	# POST https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}/train
	def train(group_id)
	  @client.post("/persongroups/#{group_id}/train")
	end

	# Update a Person Group
	# PATCH https://api.projectoxford.ai/face/v1.0/persongroups/{personGroupId}
	def update(group_id, name, user_data)
	  params = {
		name: name,
		userData: user_data
	  }
	  @client.patch("/persongroups/#{group_id}", params)
	end
  end
end
