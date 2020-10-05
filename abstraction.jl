### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 7cff5cac-06dc-11eb-39a8-edde1403930a
begin
# 	using Pkg
# 	Pkg.add(["Images", "ImageIO", "ImageMagick"])
	using Images
end

# ╔═╡ 07f76766-06db-11eb-1c7b-49bde9df7459
md"""
# Abstraction
"""

# ╔═╡ 7061bd1e-06dc-11eb-2fdc-f3730660ae84
md"""
### Importing Packages
"""

# ╔═╡ 2290419c-06db-11eb-293f-038636d18dc5
# element = "one"
# element = 1
# element = 1.0
# element = 1//1
# element = cute_smile
element = [1 2 ; 3 4]

# ╔═╡ 2278f294-06db-11eb-29fc-3d8eeac496fd
fill(element, 3, 4)

# ╔═╡ 2260a536-06db-11eb-1fec-4bdbdd2054f6
typeof(element) ## Change element to float then string and see

# ╔═╡ 2153b692-06db-11eb-3b5d-9982371603a4
cute_smile = load(download("https://fcw.com/-/media/GIG/FCWNow/Topics/Concepts/smiley.png"))

# ╔═╡ 22496cd6-06db-11eb-02b6-87138fb27ec4
keep_track = [typeof(1), typeof(1.0), typeof("floki"), typeof(1//1), typeof([1 2; 3 4]), typeof(cute_smile)]

# ╔═╡ 221a34a2-06db-11eb-0979-eb21cab33238
typeof(keep_track)

# ╔═╡ 213c8724-06db-11eb-2d20-093d41061f24


# ╔═╡ 2124b5ea-06db-11eb-358b-d1c543d25741


# ╔═╡ 210f8b48-06db-11eb-3b6f-33c82af86e20


# ╔═╡ 20f7067c-06db-11eb-39df-034832e8fbb3


# ╔═╡ 20df6968-06db-11eb-0e77-9dcbaa2a8626


# ╔═╡ 20c591f0-06db-11eb-302c-ebdc00e80b75


# ╔═╡ Cell order:
# ╠═07f76766-06db-11eb-1c7b-49bde9df7459
# ╠═7061bd1e-06dc-11eb-2fdc-f3730660ae84
# ╠═7cff5cac-06dc-11eb-39a8-edde1403930a
# ╠═2290419c-06db-11eb-293f-038636d18dc5
# ╠═2278f294-06db-11eb-29fc-3d8eeac496fd
# ╠═2260a536-06db-11eb-1fec-4bdbdd2054f6
# ╠═22496cd6-06db-11eb-02b6-87138fb27ec4
# ╠═221a34a2-06db-11eb-0979-eb21cab33238
# ╠═2153b692-06db-11eb-3b5d-9982371603a4
# ╠═213c8724-06db-11eb-2d20-093d41061f24
# ╠═2124b5ea-06db-11eb-358b-d1c543d25741
# ╠═210f8b48-06db-11eb-3b6f-33c82af86e20
# ╠═20f7067c-06db-11eb-39df-034832e8fbb3
# ╠═20df6968-06db-11eb-0e77-9dcbaa2a8626
# ╠═20c591f0-06db-11eb-302c-ebdc00e80b75
