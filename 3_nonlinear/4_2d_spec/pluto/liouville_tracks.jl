### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 6dd2e2dc-3567-4de4-950f-f43df760453b
# the code requires the following structure for a 2-sided Feynman diagram

number_of_mu = 4

# ╔═╡ 52e82dce-1218-4c4c-a745-e9c053fd1642
mutable struct Interaction
	column
	direction
end

# ╔═╡ efb61be9-c2c7-436c-9109-70f9d5103c9c
interaction = Interaction(zeros(Float64, number_of_mu +1), zeros(Float64, number_of_mu +1))

# ╔═╡ 055ef168-4d4a-4a23-ac18-3e523263af12
mutable struct Track
	states
	interaction
	phasematch
end

# ╔═╡ bedf677d-c929-4ef5-830d-6f8e2f87e670
track = Track(zeros(Float64, number_of_mu +1,2) ,interaction,zeros(Float64, number_of_mu +1,2))

# ╔═╡ 7e388706-bb14-461f-b3e1-a0213a596125
# index in first dimension is "running number of interaction + 1"
# index in second dimension is column: 1= left = ket; 2 = right = bra
# value is number of state = quanmtum number; but >=1 
# this number is reduced by 1 for display !

# we start from ground state 
track.states[1,[1,2]] .= 1;  #

# ╔═╡ 208c8f9a-f79d-4c0a-8b2c-5e263484b93d
# 1. interaction: absorption into left
track.interaction.column[2]  = 1;  # = left

# ╔═╡ 5054a8ff-8c63-4a43-bfd2-dca814592cbe
track.interaction.direction[2]  = 1;  # = absorption

# ╔═╡ e07a2266-8292-440c-b20f-22fcdfa0bf98
track.phasematch[2]  = 1;  # left-to-right

# ╔═╡ 2da196be-5631-41e1-afd4-80537b51b3b8
track.states[2,1] = 2;  # incremented quantum number

# ╔═╡ a3e6807c-9102-4f79-aaed-76a2a4684c6a
track.states[2,2] = 1;

# ╔═╡ bd25e871-8ec5-4727-ab58-f1283e56cdaa
# 2. interaction: absorption into right
track.interaction.column[3]  = 2;  # = right

# ╔═╡ 79524a19-358c-406b-98a9-b1e0bebfc07c
track.interaction.direction[3]  = 1;  # = absorption

# ╔═╡ 8ca50cdd-8945-4099-b07c-a3f1b4986300
track.phasematch[3]  = -1;  # right-to-left

# ╔═╡ d82f5002-7dfe-44e4-8058-753ffcf4e87e
track.states[3,1] = 2;  # incremented quantum number

# ╔═╡ e907721d-9ee0-4514-9778-d5a904d8033d
track.states[3,2] = 2;

# ╔═╡ 7aa68c5f-d3d0-485b-b576-121e77c915dd
# 3. interaction: emission from right 
track.interaction.column[4]  = 2;  # = right

# ╔═╡ 2e2da54a-0eaa-4414-95a1-dc283b28bc5c
track.interaction.direction[4]  = -1;  # = emission

# ╔═╡ bd572b51-0978-41ba-bd17-00298f67e9d7
track.phasematch[4]  = 1;  # left-to-right

# ╔═╡ d3eb6360-4682-4c85-8d68-6d76536c2fb9
track.states[4,1] = 2;

# ╔═╡ ce83a45d-135e-463f-b9a8-812e012a84bd
track.states[4,2] = 1;  # decremented quantum number

# ╔═╡ 549c5f14-70e1-44b1-9b0d-c60fabac5295
# 3. interaction = radiation polarization: emission from left 
track.interaction.column[5]  = 1;  # = left

# ╔═╡ 5cc2a168-9ca2-42fa-9cdb-c3cba0ce751b
track.interaction.direction[5]  = -1;  # = emission

# ╔═╡ ef95be20-0291-4721-a67e-03ba032cac28
track.phasematch[5]  = -1;  # right-to-left

# ╔═╡ ad8bbcff-147e-4bf1-a59d-5ed309697f19
track.states[5,1] = 1;  # decremented quantum number

# ╔═╡ 7d2ab482-a91d-48bb-a070-e8fbafcb64d7
track.states[5,2] = 1;

# ╔═╡ d4aae981-626b-46ee-be10-08881943b4c8
# of course on better does this with a script. Your turn ...
# we get an array of possible diagrams
# here for demo only one

tracks = [track]

# ╔═╡ 5660424e-b3bb-4b26-beef-89f4acd65d42
# display all tracks; grouped by phase matching
for id1=1:2
    for id2=1:2
        for id3=1:2
            pm = ([id1 id2 id3]' - 1.5) .* 2
            display_tracks_by_phasematch[tracks,pm]
        end
    end
end

# ╔═╡ Cell order:
# ╠═6dd2e2dc-3567-4de4-950f-f43df760453b
# ╠═52e82dce-1218-4c4c-a745-e9c053fd1642
# ╠═efb61be9-c2c7-436c-9109-70f9d5103c9c
# ╠═055ef168-4d4a-4a23-ac18-3e523263af12
# ╠═bedf677d-c929-4ef5-830d-6f8e2f87e670
# ╠═7e388706-bb14-461f-b3e1-a0213a596125
# ╠═208c8f9a-f79d-4c0a-8b2c-5e263484b93d
# ╠═5054a8ff-8c63-4a43-bfd2-dca814592cbe
# ╠═e07a2266-8292-440c-b20f-22fcdfa0bf98
# ╠═2da196be-5631-41e1-afd4-80537b51b3b8
# ╠═a3e6807c-9102-4f79-aaed-76a2a4684c6a
# ╠═bd25e871-8ec5-4727-ab58-f1283e56cdaa
# ╠═79524a19-358c-406b-98a9-b1e0bebfc07c
# ╠═8ca50cdd-8945-4099-b07c-a3f1b4986300
# ╠═d82f5002-7dfe-44e4-8058-753ffcf4e87e
# ╠═e907721d-9ee0-4514-9778-d5a904d8033d
# ╠═7aa68c5f-d3d0-485b-b576-121e77c915dd
# ╠═2e2da54a-0eaa-4414-95a1-dc283b28bc5c
# ╠═bd572b51-0978-41ba-bd17-00298f67e9d7
# ╠═d3eb6360-4682-4c85-8d68-6d76536c2fb9
# ╠═ce83a45d-135e-463f-b9a8-812e012a84bd
# ╠═549c5f14-70e1-44b1-9b0d-c60fabac5295
# ╠═5cc2a168-9ca2-42fa-9cdb-c3cba0ce751b
# ╠═ef95be20-0291-4721-a67e-03ba032cac28
# ╠═ad8bbcff-147e-4bf1-a59d-5ed309697f19
# ╠═7d2ab482-a91d-48bb-a070-e8fbafcb64d7
# ╠═d4aae981-626b-46ee-be10-08881943b4c8
# ╠═5660424e-b3bb-4b26-beef-89f4acd65d42
