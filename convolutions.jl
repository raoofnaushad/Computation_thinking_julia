### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ e8d424d8-06fc-11eb-2232-31ea1583888c
begin
# 	using Pkg
# 	Pkg.add(["Statistics", "FFTW", "Plots"])
# 	Pkg.add(["DSP", "ImageFiltering", "PlutoUI"])
	using InteractiveUtils
	using Statistics
	using Images
	using FFTW
	using Plots
	using DSP
	using ImageFiltering
	using Markdown
end

# ╔═╡ 01fe5224-06ff-11eb-3cd9-57acf800c95e
md"""
### Importing Libraries
"""

# ╔═╡ 14d546d2-06ff-11eb-2177-637614ebfd04
kernel = Kernel.gaussian((3, 3))

# ╔═╡ 14bc416e-06ff-11eb-1374-a9f4c4bf882c
kernel[0,0]

# ╔═╡ 63da4632-0700-11eb-3fdf-456fdffc9f98
## Another Example
sharpen_kernel = centered([
		-0.5 -1.0 -0.5
		-1.0  7.0 -1.0
		-0.5 -1.0 -0.5])
		

# ╔═╡ 63824522-0700-11eb-2c93-21b28550c46f
edge_det_kernel_h = Kernel.sobel()[2]

# ╔═╡ 83e5b088-072b-11eb-05ee-1f9a516d2cec
edge_det_kernel_v = Kernel.sobel()[1]

# ╔═╡ ad16d68e-072e-11eb-023c-5fd6ad5fbc1e
zebra = load("zebra.jpg")

# ╔═╡ e231b0e0-06fd-11eb-3e7c-63b92f7e04f8
md"""
## Function Defenitions
"""

# ╔═╡ 9e81c17e-06fe-11eb-1e08-fd5bc6c7b339
function shrink_image(image, ratio=5)
	(height, width) = size(image)
	new_height = height ÷ ratio - 1
	new_width = width ÷ ratio - 1
	list = [
		mean(image[
			ratio * i:ratio * (i + 1),
			ratio * j:ratio * (j + 1),
		])
		for j in 1:new_width
		for i in 1:new_height
	]
	reshape(list, new_height, new_width)
end

# ╔═╡ 9ed4670c-06fb-11eb-0987-870ff6440916
begin
	large_floki = load("dog.jpg")
	floki = shrink_image(large_floki, 2)
	floki
end

# ╔═╡ 14e9f780-06ff-11eb-352e-c3d1bab7808b
size(floki)

# ╔═╡ ad40d858-072e-11eb-0813-d1362cccd43b
floki

# ╔═╡ 9e67e20c-06fe-11eb-1bf3-993195e5e2bc
function decimate(arr, ratio=5)
	return arr[1:ratio:end, 1:ratio:end]
end

# ╔═╡ a54d31d0-06fe-11eb-276d-332aabb4278c
function show_colored_kernel(kernel)
	to_rgb(x) = RGB(max(-x, 0), max(x, 0), 0)
	to_rgb.(kernel) / maximum(abs.(kernel))
end

# ╔═╡ 14a4de70-06ff-11eb-2e71-c99031d051b8
show_colored_kernel(kernel)

# ╔═╡ c1600532-072b-11eb-050e-23983fb1ad20
show_colored_kernel(edge_det_kernel_h)

# ╔═╡ d1cca6d2-072b-11eb-0020-05b3140a3504
show_colored_kernel(edge_det_kernel_v)

# ╔═╡ bce8fe9e-0705-11eb-3ac5-8708ab3436be
function rgb_to_float(color)
    return mean([color.r, color.g, color.b])
end

# ╔═╡ bcd11e4e-0705-11eb-2b10-ed0a8f94d6a0
function fourier_spectrum_magnitudes(img)
    grey_values = rgb_to_float.(img)
    spectrum = fftshift(fft(grey_values))
	return abs.(spectrum)
end

# ╔═╡ bcb82b5c-0705-11eb-2892-f78543f912ed
function plot_1d_fourier_spectrum(img, dims=1)
	spectrum = fourier_spectrum_magnitudes(img)
	plot(centered(mean(spectrum, dims=1)[1:end]))
end

# ╔═╡ ad2a6750-072e-11eb-3836-6dd0a4f1c6fa
plot_1d_fourier_spectrum(floki)

# ╔═╡ acfd3350-072e-11eb-2978-373f09a03a0b
plot_1d_fourier_spectrum(zebra)

# ╔═╡ db2e5598-0705-11eb-2f66-b7cb5fb97a42
function heatmap_2d_fourier_spectrum(img)
	heatmap(log.(fourier_spectrum_magnitudes(img)))
end

# ╔═╡ c12e4bb8-0731-11eb-1343-1b4d8997d745
heatmap_2d_fourier_spectrum(zebra)

# ╔═╡ db13f6a8-0705-11eb-1f2a-e520b0cd0e15
function clamp_at_boundary(M, i, j)
	return M[
		clamp(i, 1, size(M, 1)),
		clamp(j, 1, size(M, 2)),	
	]
end

# ╔═╡ e6844858-0705-11eb-1b0f-6db56a57e6a9
function rolloff_boundary(M, i, j)
	if (1 ≤ i ≤ size(M, 1)) && (1 ≤ j ≤ size(M, 2))
		return M[i, j]
	else
		return 0 * M[1, 1]
	end
end

# ╔═╡ e66cf482-0705-11eb-2899-139bba101795
function convolve(M, kernel, M_index_func=clamp_at_boundary)
    height = size(kernel, 1)
    width = size(kernel, 2)
    
    half_height = height ÷ 2
    half_width = width ÷ 2
    
    new_image = similar(M)
	
    # (i, j) loop over the original image
    @inbounds for i in 1:size(M, 1)
        for j in 1:size(M, 2)
            # (k, l) loop over the neighbouring pixels
			new_image[i, j] = sum([
				kernel[k, l] * M_index_func(M, i - k, j - l)
				for k in -half_height:-half_height + height - 1
				for l in -half_width:-half_width + width - 1
			])
        end
    end
    
    return new_image
end

# ╔═╡ 63af5242-0700-11eb-0a8f-192d8a1c1f58
conv_image = convolve(floki, kernel)

# ╔═╡ 639bc506-0700-11eb-2653-bd05edc5c0f4
conv_image_s = convolve(floki, sharpen_kernel)

# ╔═╡ 636aaf02-0700-11eb-2715-49d4b5556ae0
conv_image_eh = convolve(conv_image_s, edge_det_kernel_h)

# ╔═╡ 8a7df29c-072b-11eb-3ca8-fdfa0b743b77
conv_image_ev = convolve(conv_image_s, edge_det_kernel_v)

# ╔═╡ ace46712-072e-11eb-1f35-e9f3e9a4a39e
zebra_conv = convolve(zebra, kernel)

# ╔═╡ fa0a3cd6-0730-11eb-2ec4-51d88cef9cc6
plot_1d_fourier_spectrum(zebra_conv)

# ╔═╡ cda4fed2-0731-11eb-383e-c7ed5895887b
heatmap_2d_fourier_spectrum(zebra_conv)

# ╔═╡ e652aafa-0705-11eb-067b-d960d9d115e1
function gauss_blur(n, sigma=0.25)
	kern = gaussian((n, n), sigma)
	return kern / sum(kern)
end

# ╔═╡ Cell order:
# ╠═01fe5224-06ff-11eb-3cd9-57acf800c95e
# ╠═e8d424d8-06fc-11eb-2232-31ea1583888c
# ╠═9ed4670c-06fb-11eb-0987-870ff6440916
# ╠═14e9f780-06ff-11eb-352e-c3d1bab7808b
# ╠═14d546d2-06ff-11eb-2177-637614ebfd04
# ╠═14bc416e-06ff-11eb-1374-a9f4c4bf882c
# ╠═14a4de70-06ff-11eb-2e71-c99031d051b8
# ╠═63af5242-0700-11eb-0a8f-192d8a1c1f58
# ╠═63da4632-0700-11eb-3fdf-456fdffc9f98
# ╠═639bc506-0700-11eb-2653-bd05edc5c0f4
# ╠═63824522-0700-11eb-2c93-21b28550c46f
# ╠═c1600532-072b-11eb-050e-23983fb1ad20
# ╠═636aaf02-0700-11eb-2715-49d4b5556ae0
# ╠═83e5b088-072b-11eb-05ee-1f9a516d2cec
# ╠═d1cca6d2-072b-11eb-0020-05b3140a3504
# ╠═8a7df29c-072b-11eb-3ca8-fdfa0b743b77
# ╠═ad40d858-072e-11eb-0813-d1362cccd43b
# ╠═ad2a6750-072e-11eb-3836-6dd0a4f1c6fa
# ╠═ad16d68e-072e-11eb-023c-5fd6ad5fbc1e
# ╠═c12e4bb8-0731-11eb-1343-1b4d8997d745
# ╠═acfd3350-072e-11eb-2978-373f09a03a0b
# ╠═ace46712-072e-11eb-1f35-e9f3e9a4a39e
# ╠═fa0a3cd6-0730-11eb-2ec4-51d88cef9cc6
# ╠═cda4fed2-0731-11eb-383e-c7ed5895887b
# ╟─e231b0e0-06fd-11eb-3e7c-63b92f7e04f8
# ╟─9e81c17e-06fe-11eb-1e08-fd5bc6c7b339
# ╟─9e67e20c-06fe-11eb-1bf3-993195e5e2bc
# ╟─a54d31d0-06fe-11eb-276d-332aabb4278c
# ╟─bce8fe9e-0705-11eb-3ac5-8708ab3436be
# ╠═bcd11e4e-0705-11eb-2b10-ed0a8f94d6a0
# ╠═bcb82b5c-0705-11eb-2892-f78543f912ed
# ╟─db2e5598-0705-11eb-2f66-b7cb5fb97a42
# ╟─db13f6a8-0705-11eb-1f2a-e520b0cd0e15
# ╟─e6844858-0705-11eb-1b0f-6db56a57e6a9
# ╟─e66cf482-0705-11eb-2899-139bba101795
# ╟─e652aafa-0705-11eb-067b-d960d9d115e1
