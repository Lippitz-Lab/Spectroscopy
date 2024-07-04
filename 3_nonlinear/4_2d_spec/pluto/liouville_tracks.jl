### A Pluto.jl notebook ###
# v0.19.42

using Markdown
using InteractiveUtils

# ╔═╡ 6dd2e2dc-3567-4de4-950f-f43df760453b
# the code requires the following structure for a 2-sided Feynman diagram
number_of_mu = 4;

# ╔═╡ 52e82dce-1218-4c4c-a745-e9c053fd1642
begin
	@enum Side left right
	@enum Direction inward outward
	
	mutable struct Interaction
		side :: Side
		direction :: Direction
	end
	
	mutable struct State
			bra :: Int 
			ket :: Int
	end

	mutable struct Track
		states :: Array{State, 1}
		interaction :: Array{Interaction,1}
	end
end

# ╔═╡ 7e388706-bb14-461f-b3e1-a0213a596125
begin
		track = Track(
			Array{State, 1}(undef, number_of_mu +1) ,
			Array{Interaction,1}(undef, number_of_mu + 1)
	)
	
		# interaction between step A and B is at index position of B
		
		# we start from ground state 
		track.states[1] =  State(0,0)  
	
		# 1. interaction: absorption into left
		track.interaction[2] = Interaction(left, inward)
		track.states[2] = State(1,0)  ;  # incremented quantum number

		# 2. interaction: absorption into right
		track.interaction[3]  = Interaction(right, inward);  
		track.states[3] = State(1,1)  ;  # incremented quantum number

		# 3. interaction: emission from right 
		track.interaction[4]  = Interaction(right, outward);  
		track.states[4] = State(1,0)  ;  # decremented quantum number

		# 4. interaction = radiation polarization: emission from left 
		track.interaction[5]  = Interaction(left, outward);  
		track.states[5] = State(0,0)  ;  # decremented quantum number

end;

# ╔═╡ d4aae981-626b-46ee-be10-08881943b4c8
# of course on better does this with a script. Your turn ...
# we get an array of possible diagrams
# here for demo only one

tracks = [track]

# ╔═╡ 3d89dfb3-7788-4ce3-b395-90137d8a8ceb
function calc_phasematch(interaction::Interaction)
	if ( (interaction.side == left)  & (interaction.direction == inward)) |
		((interaction.side == right) & (interaction.direction == outward))
		pm = '+'
	else
		pm = '-'
	end
	return pm
end

# ╔═╡ 2e706899-ced8-4f23-b654-890832704502
function display_track(tracks)
    # displays tracks as double-sided Feynman diagrams
    # all tracks have to fit in one line !

    s = size(tracks[1].states)

    # print double sided Feynman diag.
    # from top to bottom = backwards in time
    for id in reverse(1:s[1])
        for id2 in 1:length(tracks)
			if (id > 1)
		            interaction = tracks[id2].interaction[id].direction == inward ? "+" : "-"
			
		            if tracks[id2].interaction[id].side == left
		                sl = interaction
		                sr = " "
		            else
		                sl = " "
		                sr = interaction
		            end
			else
				sl = " "
				sr = " "
			end

			a = tracks[id2].states[id].bra
			b = tracks[id2].states[id].ket  
			
            print("$sl| $(a) $(b) |$sr       ")
        end
        println()
    end

    # print phase matching signs
    print("   ")
    for id2 in 1:length(tracks)
        for id in 2:s[1]
            print(calc_phasematch(tracks[id2].interaction[id]))
        end
        print("            ")
    end
    println()
end

# ╔═╡ f750e54f-b178-4279-b950-3002e7ea0ba2
display_track(tracks)

# ╔═╡ 11a17f82-c76d-4f33-86d3-57117ce0afe2
function select_by_phasematch(tracks, pm)
    # select those tracks that fulfill phasematching condition
    # pm: string of * / -
    
    n = length(pm)
    
    ok = falses(length(tracks))
    for id in 1:length(tracks)
        ok[id] = (join(calc_phasematch.(tracks[id].interaction[2:end])) == pm)
    end
    
    return ok
end

# ╔═╡ 39b85b65-b020-476f-aede-6b5bfcd5114e
function display_tracks_by_phasematch(tracks, phasematch)
    # select the tracks
    tr = tracks[select_by_phasematch(tracks, phasematch)]

    # distribute tracks in lines of 4
    tracks_per_line = 4
    n = floor(Int, length(tr) / tracks_per_line)
    rem = length(tr) - n * tracks_per_line

    for id in 0:(n-1)
        display_track(tr[(id*tracks_per_line +1):(id*tracks_per_line + tracks_per_line)])
        println()
    end

    if (rem > 0)
        display_track(tr[end-rem+1:end])
    end
    
    println("\n")
end

# ╔═╡ 5660424e-b3bb-4b26-beef-89f4acd65d42
begin
	# display all tracks; grouped by phase matching
	
	signs = ['+','-']
	for id1 in signs
	    for id2 in signs
	        for id3 in signs
	            pm = join([id1 , id2,  id3, '-'] )  # last is always -
	            display_tracks_by_phasematch(tracks,pm)
	        end
	    end
	end
end

# ╔═╡ Cell order:
# ╠═6dd2e2dc-3567-4de4-950f-f43df760453b
# ╠═52e82dce-1218-4c4c-a745-e9c053fd1642
# ╠═7e388706-bb14-461f-b3e1-a0213a596125
# ╠═d4aae981-626b-46ee-be10-08881943b4c8
# ╠═5660424e-b3bb-4b26-beef-89f4acd65d42
# ╠═f750e54f-b178-4279-b950-3002e7ea0ba2
# ╠═2e706899-ced8-4f23-b654-890832704502
# ╠═39b85b65-b020-476f-aede-6b5bfcd5114e
# ╠═11a17f82-c76d-4f33-86d3-57117ce0afe2
# ╠═3d89dfb3-7788-4ce3-b395-90137d8a8ceb
