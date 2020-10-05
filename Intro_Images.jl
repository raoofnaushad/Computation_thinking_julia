### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ fa92c408-05ae-11eb-044a-af22466e887a
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add(["Images", "ImageIO", "ImageMagick"])
	using Images
	Pkg.add("PlutoUI")
	using PlutoUI
end

# ╔═╡ 08ffe7aa-05af-11eb-33d7-a9694d24d415
url = "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/golden-retriever-royalty-free-image-506756303-1560962726.jpg?crop=1.00xw:0.756xh;0,0.0756xh&resize=980:*"

# ╔═╡ 1c3b45a8-05af-11eb-04c7-a180a3d68ea4
download(url, "dog.jpg")

# ╔═╡ 4198f79e-05af-11eb-1b1c-31b09f75ae32
dog = load("dog.jpg")

# ╔═╡ 53fa737e-05af-11eb-2408-614842cd4e20
typeof(dog)

# ╔═╡ 57d46484-05af-11eb-3f60-91c761183c7e
RGB(255/255, 255/255, 0/255)

# ╔═╡ 60ca33d2-05af-11eb-3d1b-b1d30f309c19
size(dog)

# ╔═╡ 6490a1d6-05af-11eb-0ce8-a119400016fc
dog[200,200]

# ╔═╡ 67b0efba-05af-11eb-3666-83a1b919382e
dog[100:300, 100:500]

# ╔═╡ 6dc47502-05af-11eb-2067-89205326cf8c
begin 
	h, w = size(dog)
	head = dog[h÷10:4*h÷10, 2*w÷4: 3*w÷4]
end

# ╔═╡ 6f937e82-05af-11eb-004e-391ebbda4757
size(head)

# ╔═╡ 75ca3a3e-05af-11eb-1995-dde0c7814262
md"""
## Manipulating Matrices
"""

# ╔═╡ 7d307e3c-05af-11eb-02ed-85fe9797f1a7
[head head head]

# ╔═╡ 7d1c4070-05af-11eb-0bb5-998387b6d467
size([head head head])  ## It is twice than 

# ╔═╡ 7d0924f4-05af-11eb-360e-d71477a46e48
[
head reverse(head, dims=2)
head reverse(head, dims=2)
]

# ╔═╡ 7cf1e992-05af-11eb-03bc-335835b4e880
md"""
## Manipulating an Image
"""

# ╔═╡ 7cda8c20-05af-11eb-0588-5359aa130aaa
begin
	_dog = copy(head)
	dog_head = copy(head)
end

# ╔═╡ 7cc2b1e0-05af-11eb-2105-cfd8475f8d79
some_color = RGB(150/255, 150/255, 0/255)

# ╔═╡ 7ba6fa50-05af-11eb-1680-b3c63be9ec01
size(dog_head)

# ╔═╡ 941d75b4-05af-11eb-1bcd-8d1095538c6f
for i in 1:40
	for j in 1:40
		dog_head[i,j] = some_color
	end
end

# ╔═╡ 985307ae-05af-11eb-1688-73069a19a08e
dog_head

# ╔═╡ 9a2f7358-05af-11eb-3209-83ab50bea318
begin
	dog_head2 = copy(dog_head)
	dog_head2[40:45, 40:80] .= RGB(0, 0, 1)
	dog_head2
end

# ╔═╡ 9f2b44a4-05af-11eb-0c94-e59a4a3ceefe
function redify(color)
	return RGB(color.r, 0, 0)
end


# ╔═╡ a34e4748-05af-11eb-31cb-8770282de055
begin
	color = RGB(0.9, 0.4, 0.3)
	[color, redify(color)]
end


# ╔═╡ a6ed845e-05af-11eb-1c8f-f5f769462436
redify.(dog)

# ╔═╡ ba3fe48e-05af-11eb-3913-4d0c60e11084
md"""
What the above functiion does is keep the red color of eachh pixel and strip away the rest
"""

# ╔═╡ c32dae1e-05af-11eb-19ec-079d88682323
md"""
## Transforming an Image
#### Decimate
"""

# ╔═╡ 04926f52-05b0-11eb-185f-157ecadfa951
decimate(image, ratio=5) = image[1:ratio:end, 1:ratio:end]

# ╔═╡ c3169942-05af-11eb-1591-27d9a510a88d
begin
	poor_dog = decimate(dog, 5)
	size(dog_head)
	size(poor_dog)
	poor_dog
end

# ╔═╡ c8084976-05af-11eb-0c9f-efcc9b14ae6f
convolve

# ╔═╡ c303efb6-05af-11eb-0ad9-bd9fe9371039


# ╔═╡ c2ed34c4-05af-11eb-00e0-3b0c4d115e6a


# ╔═╡ c2dad1b2-05af-11eb-0997-25e0df7ba9a9


# ╔═╡ bdeda80a-05af-11eb-334c-39baf2a9e793


# ╔═╡ Cell order:
# ╠═fa92c408-05ae-11eb-044a-af22466e887a
# ╠═08ffe7aa-05af-11eb-33d7-a9694d24d415
# ╠═1c3b45a8-05af-11eb-04c7-a180a3d68ea4
# ╠═4198f79e-05af-11eb-1b1c-31b09f75ae32
# ╠═53fa737e-05af-11eb-2408-614842cd4e20
# ╠═57d46484-05af-11eb-3f60-91c761183c7e
# ╠═60ca33d2-05af-11eb-3d1b-b1d30f309c19
# ╠═6490a1d6-05af-11eb-0ce8-a119400016fc
# ╠═67b0efba-05af-11eb-3666-83a1b919382e
# ╠═6dc47502-05af-11eb-2067-89205326cf8c
# ╠═6f937e82-05af-11eb-004e-391ebbda4757
# ╠═75ca3a3e-05af-11eb-1995-dde0c7814262
# ╠═7d307e3c-05af-11eb-02ed-85fe9797f1a7
# ╠═7d1c4070-05af-11eb-0bb5-998387b6d467
# ╠═7d0924f4-05af-11eb-360e-d71477a46e48
# ╠═7cf1e992-05af-11eb-03bc-335835b4e880
# ╠═7cda8c20-05af-11eb-0588-5359aa130aaa
# ╠═7cc2b1e0-05af-11eb-2105-cfd8475f8d79
# ╠═7ba6fa50-05af-11eb-1680-b3c63be9ec01
# ╠═941d75b4-05af-11eb-1bcd-8d1095538c6f
# ╠═985307ae-05af-11eb-1688-73069a19a08e
# ╠═9a2f7358-05af-11eb-3209-83ab50bea318
# ╠═9f2b44a4-05af-11eb-0c94-e59a4a3ceefe
# ╠═a34e4748-05af-11eb-31cb-8770282de055
# ╠═a6ed845e-05af-11eb-1c8f-f5f769462436
# ╠═ba3fe48e-05af-11eb-3913-4d0c60e11084
# ╠═c32dae1e-05af-11eb-19ec-079d88682323
# ╠═04926f52-05b0-11eb-185f-157ecadfa951
# ╠═c3169942-05af-11eb-1591-27d9a510a88d
# ╠═c8084976-05af-11eb-0c9f-efcc9b14ae6f
# ╠═c303efb6-05af-11eb-0ad9-bd9fe9371039
# ╠═c2ed34c4-05af-11eb-00e0-3b0c4d115e6a
# ╠═c2dad1b2-05af-11eb-0997-25e0df7ba9a9
# ╠═bdeda80a-05af-11eb-334c-39baf2a9e793
