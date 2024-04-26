### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 64e5e028-03ae-11ef-3415-e5c30d616456
using Unitful

# ╔═╡ 81d4e233-1a93-4697-95cf-e6cf2ea3e853
module MyUnits
	using Unitful
	@unit D "D" Debye 3.33e-30u"C*m" true;
end

# ╔═╡ b3f1e66a-7b5e-453d-82ac-de98e64e823d
md"""
## 4 Mie Scattering: Check Units
"""

# ╔═╡ 312fe7dd-e5bc-4ec3-b1af-a7fc8cdb6e6c
import PhysicalConstants.CODATA2018: N_A	, m_e, e, ε_0, c_0, ħ

# ╔═╡ 6158fb0c-850d-4018-b37c-8e87bd3431eb
Unitful.register(MyUnits);

# ╔═╡ 8001c660-6d55-4d09-a47c-101adf919214
md"""
### Rayleigh scattering
"""

# ╔═╡ 449a9400-662b-4728-88f8-7e45155aa58f
ϵ_out = 1;

# ╔═╡ 9a1e758d-5313-4b1e-9f39-f452b6cf42f6
ϵ_in = -5;

# ╔═╡ 5b816cec-4a1c-4de2-8d89-0f5d92d1aaaa
R = 10u"nm";

# ╔═╡ 5f354db7-5009-4d90-b958-fd5be03e31f7
α = 4 * pi * R^3 * (ϵ_in - ϵ_out) / (ϵ_in + ϵ_out)

# ╔═╡ 95981b85-2036-4272-b5b5-473bf53950ce
E = 1u"V/m"

# ╔═╡ 8bad7be1-be7f-467c-ae7b-e6b81d817d6d
p = ε_0 * ϵ_out * α * E |> upreferred

# ╔═╡ ca98b16b-69e0-4ca3-96ba-419e661df9b9
λ = 600u"nm";

# ╔═╡ 6243761d-0df4-4739-a391-11b18fa0e082
k = 2 * pi / λ

# ╔═╡ c546666c-79a2-4cb4-872d-dfbefe07423a
r = 1u"cm"

# ╔═╡ 3bcdbf56-bdd2-45d0-8cf0-082738ab728b
ES = 1 / (4 * pi * ε_0 * ϵ_out) * (k * r)^2 / r^3 * p |> u"V/m"

# ╔═╡ 6ab45401-4478-450e-ac27-ec12910591b1
PS = c_0 / (12 * pi *  ε_0 * ϵ_out) * k^4 * p^2 |> u"W"

# ╔═╡ 8219de26-5235-497d-86ad-fda548be0d14
PS_2 = (c_0 *  ε_0 * ϵ_out) / ( 12 * pi) * k^4 * α^2 * E^2 |> u"W"

# ╔═╡ 9fa782b4-0223-4db9-8d02-377f6be26ee6
S = 0.5 * c_0 *  ε_0 * ϵ_out * E^2 |> u"W/m^2"

# ╔═╡ 95e05063-5356-4435-9767-293c7d8fe7ee
σ_scat = PS / S |> u"nm^2"

# ╔═╡ d7f7be11-cba3-4c4b-b25e-82b0fec4c549
σ_scat_2 = k^4 / (6 * pi) * α^2

# ╔═╡ 7b066825-773c-46bd-94ca-9fb7d071f3f0
md"""
### Optical Theorem
"""

# ╔═╡ ec964896-7bc3-4aa2-b479-f0d58376750a
I = 0.5 * c_0 *  ε_0 * ϵ_out * E^2 |> u"W/m^2"

# ╔═╡ b27c6631-0525-4898-ab92-30bec6ec41b7
Pscreen = I * 1u"m^2"

# ╔═╡ aa033292-6a70-42c9-ba6c-16cb49f99841
md"""
### small sphere
"""

# ╔═╡ 40ddfea0-7d62-482d-8f33-a6be11934362
f = k^2 / (4 * pi) * α

# ╔═╡ 5bce7793-8795-476d-8a61-75197f035ed4
σ = k * α

# ╔═╡ 3df612cc-cef4-4ea6-88a9-74b1ef8c192b
ω = c_0 * k |> u"Hz"

# ╔═╡ 970bd3f5-0fe5-4519-adf6-7ec74079d39b
Pabs = (ω ) * p * E |> u"W"

# ╔═╡ e597d6cc-5b29-43ce-a507-c118bcb32360
σ_abs = k * α

# ╔═╡ 54273a11-8c7f-45c9-a125-3fcec371a35f
σ_scat2 = k^4 / (4 + pi) * α^2

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
git-tree-sha1 = "260fd2400ed2dab602a7c15cf10c1933c59930a2"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.5"

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
git-tree-sha1 = "896385798a8d49a255c398bd49162062e4a4c435"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.13"
weakdeps = ["Dates"]

    [deps.InverseFunctions.extensions]
    DatesExt = "Dates"

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
git-tree-sha1 = "1ab580704784260ee5f45bffac810b152922747b"
uuid = "f2b01f46-fcfa-551c-844a-d8ac1e96c665"
version = "2.1.5"

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
# ╟─b3f1e66a-7b5e-453d-82ac-de98e64e823d
# ╠═64e5e028-03ae-11ef-3415-e5c30d616456
# ╠═312fe7dd-e5bc-4ec3-b1af-a7fc8cdb6e6c
# ╠═81d4e233-1a93-4697-95cf-e6cf2ea3e853
# ╠═6158fb0c-850d-4018-b37c-8e87bd3431eb
# ╟─8001c660-6d55-4d09-a47c-101adf919214
# ╠═449a9400-662b-4728-88f8-7e45155aa58f
# ╠═9a1e758d-5313-4b1e-9f39-f452b6cf42f6
# ╠═5b816cec-4a1c-4de2-8d89-0f5d92d1aaaa
# ╠═5f354db7-5009-4d90-b958-fd5be03e31f7
# ╠═95981b85-2036-4272-b5b5-473bf53950ce
# ╠═8bad7be1-be7f-467c-ae7b-e6b81d817d6d
# ╠═ca98b16b-69e0-4ca3-96ba-419e661df9b9
# ╠═6243761d-0df4-4739-a391-11b18fa0e082
# ╠═c546666c-79a2-4cb4-872d-dfbefe07423a
# ╠═3bcdbf56-bdd2-45d0-8cf0-082738ab728b
# ╠═6ab45401-4478-450e-ac27-ec12910591b1
# ╠═8219de26-5235-497d-86ad-fda548be0d14
# ╠═9fa782b4-0223-4db9-8d02-377f6be26ee6
# ╠═95e05063-5356-4435-9767-293c7d8fe7ee
# ╠═d7f7be11-cba3-4c4b-b25e-82b0fec4c549
# ╟─7b066825-773c-46bd-94ca-9fb7d071f3f0
# ╠═ec964896-7bc3-4aa2-b479-f0d58376750a
# ╠═b27c6631-0525-4898-ab92-30bec6ec41b7
# ╟─aa033292-6a70-42c9-ba6c-16cb49f99841
# ╠═40ddfea0-7d62-482d-8f33-a6be11934362
# ╠═5bce7793-8795-476d-8a61-75197f035ed4
# ╠═3df612cc-cef4-4ea6-88a9-74b1ef8c192b
# ╠═970bd3f5-0fe5-4519-adf6-7ec74079d39b
# ╠═e597d6cc-5b29-43ce-a507-c118bcb32360
# ╠═54273a11-8c7f-45c9-a125-3fcec371a35f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
