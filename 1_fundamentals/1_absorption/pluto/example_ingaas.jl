### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 75f028e7-f652-4812-a8e7-5cb3cf591795
using Unitful

# ╔═╡ fe1d8e91-dbb4-47bc-83db-94f3e53e6882
module MyUnits
	using Unitful
	@unit D "D" Debye 3.33e-30u"C*m" true;
end

# ╔═╡ 7b5a716c-e134-11ee-39b0-13610ab19167
md"""
# 1 Absorption
"""

# ╔═╡ 23b0ca41-7319-415e-b436-e2b5694ae669
import PhysicalConstants.CODATA2018: N_A	, m_e, e, ε_0, c_0, ħ

# ╔═╡ 711acd5f-a09e-43aa-80b9-7275332b2bbc
md"""
Define Debye as unit
"""

# ╔═╡ 3c2b65ba-e796-4f03-83ca-59d127ad9d87
Unitful.register(MyUnits);

# ╔═╡ cda2ab43-1e52-41da-9a9a-7c3273c89861
md"""
## Transition dipole moment and cross section from absorption
"""

# ╔═╡ ba2931c1-d042-4304-b2a8-3b7631f39116
n_ingaas = 3.5;

# ╔═╡ d0a16e08-1370-4f37-8d4f-ad280c2e7c8a
md"""
from inset Fig 2b: E = 1.15 eV
"""

# ╔═╡ ae87e7be-7ff2-4671-918d-d1127a2f6f74
E = 1.15u"eV"

# ╔═╡ aff48022-022c-427c-a886-36b06dc7ea55
ω = E / ħ |> u"Hz"

# ╔═╡ 16d73670-113d-4fb9-b0c5-c1857702763e
md"""
The text says 'This is consistent with $\mu = 31$D deduced from the measured small-signal absorption coefficient ($\alpha = 30$ cm$^{-1}$) with a dot areal density of $2 \times 10^{10}$ cm$^{-2}$ and a size of the waveguide mode in the growth axis of 0.37 μm intensity FWHM'.
"""

# ╔═╡ 70cd014f-d155-40c5-b974-689fc0e6a782
md"""
All dots are sitting in one plane at the given areal density. The waveguide runs within this plane. The extend of the mode field perpendicular to the plane = in the growth axis is given. The size in the other direction does not matter, as more dots would see the waveguide when it would be larger.
"""

# ╔═╡ d9aa6449-1703-4c1d-b6c6-f26f89883e6e
md"""
Lets assume that the mode has a rectangular profile. We calculate the absorption cross section similar to eq. 1.4
```math
1 - T = \sigma \frac{C_{area}}{h_{mode}} \, dx = \alpha \, dx
```
"""

# ╔═╡ af6e8274-6a26-4390-ac05-9658001106a2
md"""
3 layers of QD
"""

# ╔═╡ 02dbc4b2-8aa5-4202-bbb8-5e2b1e8d1cc5
C_area = 3 * 2e10u"cm^-2";

# ╔═╡ da3193cd-d21d-407a-ba67-2774aecbf606
h_mode = 0.37u"μm";

# ╔═╡ d4fea2c5-86a8-4724-9c17-996ad9b6e45c
α = 30u"cm^-1";

# ╔═╡ e7f75860-09dd-4c03-a685-c5289a4c5b64
σ = α * h_mode / C_area  |> u"nm^2"

# ╔═╡ 37a9a9fe-15ee-4a35-9268-3cdfad4d677a
ϵ = σ * N_A /  log(10) |> u"M^-1*cm^-1"

# ╔═╡ 0256ecf0-3fc7-4da9-9b17-5fef132c3ba2
md"""
From here we calculate the transition dipole moment, taking into account the inhomogeneous broadening to $\Delta = 60$meV. For simplicity, we assume a rectangular lineshape.
"""

# ╔═╡ d21b0d8b-f248-4104-a067-040ff6ab0145
Δ = 60u"meV"/ħ |> u"ns^-1"

# ╔═╡ 8997f5bb-aeac-4803-a9e4-71d3f5bf98b9
μ_v2a = sqrt( ϵ / ω * Δ * log(10) * ħ * (c_0 * n_ingaas   *  ε_0 )  / (π * N_A)) |> u"D"

# ╔═╡ 4ac32490-5791-4a8d-a8e1-ae49c719b550
md"""
This is off by a factor of 2 for the transition dipole moment or probably a factor of 4 in the other quantities. Leaving out $n_{ingaas}$ gives the correct result, but does not seem to be OK.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PhysicalConstants = "5ad8b20f-a522-5ce9-bfc9-ddf1d5bda6ab"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
PhysicalConstants = "~0.2.3"
Unitful = "~1.19.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "bd1fe6de7f03bd2d0dad6d1281c5730f984a1323"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "LinearAlgebra", "MacroTools", "Markdown", "Test"]
git-tree-sha1 = "c0d491ef0b135fd7d63cbc6404286bc633329425"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.36"

    [deps.Accessors.extensions]
    AccessorsAxisKeysExt = "AxisKeys"
    AccessorsIntervalSetsExt = "IntervalSets"
    AccessorsStaticArraysExt = "StaticArrays"
    AccessorsStructArraysExt = "StructArrays"
    AccessorsUnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    Requires = "ae029012-a4dd-5104-9daa-d747884805df"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "575cd02e080939a33b6df6c5853d14924c08e35b"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.23.0"

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

    [deps.ChainRulesCore.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c53fc348ca4d40d7b371e71fd52251839080cbc9"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.4"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "68772f49f54b479fa88ace904f6127f0a3bb2e46"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.12"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Measurements]]
deps = ["Calculus", "LinearAlgebra", "Printf", "Requires"]
git-tree-sha1 = "bdcde8ec04ca84aef5b124a17684bf3b302de00e"
uuid = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
version = "2.11.0"

    [deps.Measurements.extensions]
    MeasurementsBaseTypeExt = "BaseType"
    MeasurementsJunoExt = "Juno"
    MeasurementsRecipesBaseExt = "RecipesBase"
    MeasurementsSpecialFunctionsExt = "SpecialFunctions"
    MeasurementsUnitfulExt = "Unitful"

    [deps.Measurements.weakdeps]
    BaseType = "7fbed51b-1ef5-4d67-9085-a4a9b26f478c"
    Juno = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.PhysicalConstants]]
deps = ["Measurements", "Roots", "Unitful"]
git-tree-sha1 = "cd4da9d1890bc2204b08fe95ebafa55e9366ae4e"
uuid = "5ad8b20f-a522-5ce9-bfc9-ddf1d5bda6ab"
version = "0.2.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Roots]]
deps = ["Accessors", "ChainRulesCore", "CommonSolve", "Printf"]
git-tree-sha1 = "b7e530ab28c9e19bf1742de77badbd3c943541e5"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.1.3"

    [deps.Roots.extensions]
    RootsForwardDiffExt = "ForwardDiff"
    RootsIntervalRootFindingExt = "IntervalRootFinding"
    RootsSymPyExt = "SymPy"
    RootsSymPyPythonCallExt = "SymPyPythonCall"

    [deps.Roots.weakdeps]
    ForwardDiff = "f6369f11-7733-5829-9624-2563aa707210"
    IntervalRootFinding = "d2bf35a9-74e0-55ec-b149-d360ff49b807"
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"
    SymPyPythonCall = "bc8888f7-b21e-4b7c-a06a-5d9c9496438c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"
weakdeps = ["ConstructionBase", "InverseFunctions"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─7b5a716c-e134-11ee-39b0-13610ab19167
# ╠═75f028e7-f652-4812-a8e7-5cb3cf591795
# ╠═23b0ca41-7319-415e-b436-e2b5694ae669
# ╟─711acd5f-a09e-43aa-80b9-7275332b2bbc
# ╠═fe1d8e91-dbb4-47bc-83db-94f3e53e6882
# ╠═3c2b65ba-e796-4f03-83ca-59d127ad9d87
# ╟─cda2ab43-1e52-41da-9a9a-7c3273c89861
# ╟─16d73670-113d-4fb9-b0c5-c1857702763e
# ╠═ba2931c1-d042-4304-b2a8-3b7631f39116
# ╟─d0a16e08-1370-4f37-8d4f-ad280c2e7c8a
# ╠═ae87e7be-7ff2-4671-918d-d1127a2f6f74
# ╠═aff48022-022c-427c-a886-36b06dc7ea55
# ╟─70cd014f-d155-40c5-b974-689fc0e6a782
# ╟─d9aa6449-1703-4c1d-b6c6-f26f89883e6e
# ╟─af6e8274-6a26-4390-ac05-9658001106a2
# ╠═02dbc4b2-8aa5-4202-bbb8-5e2b1e8d1cc5
# ╠═da3193cd-d21d-407a-ba67-2774aecbf606
# ╠═d4fea2c5-86a8-4724-9c17-996ad9b6e45c
# ╠═e7f75860-09dd-4c03-a685-c5289a4c5b64
# ╠═37a9a9fe-15ee-4a35-9268-3cdfad4d677a
# ╟─0256ecf0-3fc7-4da9-9b17-5fef132c3ba2
# ╠═d21b0d8b-f248-4104-a067-040ff6ab0145
# ╠═8997f5bb-aeac-4803-a9e4-71d3f5bf98b9
# ╟─4ac32490-5791-4a8d-a8e1-ae49c719b550
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
