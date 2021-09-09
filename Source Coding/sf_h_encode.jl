### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 131bdd70-0c6b-11ec-324c-397d22bc0fc8
md"""
## Source Coding Algorithms
"""

# ╔═╡ b410f023-6dbf-4053-bf0e-afa76251c2fb
begin
	H(p::Vector{Float64}) = sum(@. -p*log2(p));
	
	md"""
	---
	It return the entropy of given symbols
	
	$$H = \sum-p\log_2(p)$$
	```julia
	H(p::Vector{Float64})
	```
	"""
end

# ╔═╡ 1b58bc4a-6780-4c2e-94fe-b721b87d6972
begin
	I(p::Float64) = @. -log2(p)
	md"""
	It returns the information in symbol of probability $p$
	
	$$I = -\log_2(p)$$ 
	```julia
	I(p::Float64)
	```
	---
	"""
end

# ╔═╡ b244fa31-7d3f-437b-ba02-1edb51b66841
md""" 
#### Shannon Fano Coding Algorithm
"""

# ╔═╡ bc9c3a6d-040a-4e57-a06b-bf7ec52815bc
begin
mutable struct tree
	head::Vector{Float64}
	left_prob::Union{tree, Nothing}
	right_prob::Union{tree, Nothing}
	S::Float64
	B :: Union{String, Nothing}
	
	function tree(v::Vector{Float64}, B="", L=nothing, R=nothing)
		head = sort!(v, rev=true)
		sum_p = sum(head)
		
		if L isa Vector{Float64}
			L = tree(L, nothing, nothing)
			# leftbits = leftbits*'0'
			
		end
		if R isa Vector{Float64}
			R = tree(L, nothing, nothing)
			# rightbits = rightbits*'1'
		end
		
		return new(v, L, R, sum_p, B)
	end
end
md"""
```julia
struct tree
```
"""
end

# ╔═╡ c1882359-61e9-456d-8b61-ccea75f643be
# function encode(t::tree)
# 	if length(t.head) == 1
# 		# push!(b)
# 		return t
# 	end
	
# 	sumTotal = t.S
# 	P = t.head
# 	cost = sumTotal
# 	sL = 0
# 	for i=1:length(P)
# 		sL += P[i]
# 		newCost = abs(2*sL - sumTotal) 
# 		if newCost < cost
# 			cost = newCost 
# 			continue
# 		end
		
# 		L = P[1:i-1]
# 		R = P[i:end]
# 		t.left_prob = encode(tree(L, t.B*'0'))
# 		t.right_prob = encode(tree(R, t.B*'1'))
		
# 		break
# 	end
# 	return t
# end

md"""
```julia
encode(t::tree)
```
---
"""

# ╔═╡ 2490492b-e2e6-42c0-b9a6-08c3ec694b5b
md"""
#### Huffman Coding Algorithm
"""

# ╔═╡ 494fd53c-d15b-4b64-8494-eebcbf28179d
begin
mutable struct nodeH
	p::Float64
	left::Union{Nothing, nodeH}
	right::Union{Nothing, nodeH}
	code::Union{Nothing, String}
	c::Union{Char, Nothing}
	
	function nodeH(p, l=nothing, r=nothing, code="", c=nothing)
		return new(p, l, r, code, c);
	end
end
	
	md"""
	```julia
	struct nodeH
	```
	"""
end

# ╔═╡ f56c74e1-89a6-41d6-b3f6-8a9739aa34cf
begin
function makeTree(p::Vector{nodeH})
	if length(p) == 1
		return p[1]
	end
	p = sort!(p, rev=true, by = x -> x.p)
	p_end = pop!(p)
	p_end.code *= '1'
	p[end].code *= '0'
	p[end] = nodeH(p_end.p + p[end].p, p[end], p_end)
	makeTree(p)
end
	
	md"""
	```julia
	makeTree(p::Vector{nodeH}) -> ::nodeH
	```
	"""
end

# ╔═╡ 55e3eb24-260a-4122-a3c2-3877834bb49e
begin
struct SymS
	p::Float64
	c::Char
	code::String
end

	md"""
	```julia
	struct SymS
	```
	---
	"""
end

# ╔═╡ 27243ab6-ead5-4258-82f5-421f248d573e
begin
mutable struct msg
	p::Vector{Float64}
	msg_bits::Union{Vector{String}, Nothing}
	H::Float64
	I::Vector{Float64}
	# L::Vector{Int16}
	L::Float64
	c::Union{Nothing, Vector{Char}}
		
	function msg(p, msg_bits=nothing)
		I = []
		H = 0
		L = 0
	
		for j in 1:length(p)
			i = -log2(p[j])
			H += p[j]*i
			push!(I, -log2(p[j]))
			
			if !(msg_bits isa Nothing)
				l = length(msg_bits[j])
				L += p[j]*l
			else
				L = 0
			end
			
		end
		return new(p, msg_bits, H, I, L, nothing)
	end
		
	function msg(s::Vector{SymS})
		p = getproperty.(s, :p)
		m = getproperty.(s, :code)
		cs = getproperty.(s, :c)

		newS = msg(p, m)
		newS.c = cs
		return newS
	end
end
	
md"""
```julia
struct msg
```
"""
end

# ╔═╡ 18a2d6cf-ceb6-4b42-9933-9252b89937f2
begin
function shannonFano(P::Vector{Float64})

	let 
		global b = []
		function encode(t::tree)
			if length(t.head) == 1
				push!(b, t.B)
				return t
			end

			sumTotal = t.S
			P = t.head
			cost = sumTotal
			sL = 0
			for i=1:length(P)
				sL += P[i]
				newCost = abs(2*sL - sumTotal) 
				if newCost < cost
					cost = newCost 
					continue
				end

				L = P[1:i-1]
				R = P[i:end]
				t.left_prob = encode(tree(L, t.B*'0'))
				t.right_prob = encode(tree(R, t.B*'1'))

				break
			end
			return t
		end
		tf = encode(tree(P))
		return msg(tf.head, b)
	end
end;

md"""
```julia
shannonFano(P::Vector{Float64})

begin
	code1 = shannonFano([0.385, 0.175, 0.154, 0.154, 0.128])
	println(code1)
end

> ["00", "01", "10", "110", "111"]
```
"""
end

# ╔═╡ 7780fbf2-382c-4bce-884f-932a4e4e4cde
begin
	# code1 = encode(tree([0.4, 0.2, 0.2, 0.2]))
	code1 = shannonFano([0.10, 0.15, 0.30, 0.16, 0.29])
	code1
end

# ╔═╡ 2412a223-36fd-4d3f-b932-25c93cd8c1c5
begin
function huffman(P::Vector{Float64})
	let 
		b1 = SymS[]
		start = 'a'
		tf = nodeH[]
		j = 0
		for i in P
			push!(tf, nodeH(i, nothing, nothing, "" , start + j))
			j += 1
		end
		println(tf)
		
		tf = makeTree(tf)

		function encode(node::nodeH)
			if node.left == nothing
				push!(b1, SymS(node.p, node.c, node.code)) 
				# println(node.code)
				return node
			end

			node.left.code = '0' * node.code 
			node.right.code = '1' * node.code 

			encode(node.left)
			encode(node.right)
		end
		encode(tf)
		return sort!(b1, by = x -> x.c)
	end
end
	
	md"""
	```julia
	function huffman(P::Vector{Float64})
	
	begin
		code1 = huffman([0.4, 0.2, 0.2, 0.1, 0.1])
		code1
	end
	```
	"""

end

# ╔═╡ e899a949-84cb-45f9-bbb8-c155fae7fe20
begin
	s = huffman([0.10, 0.15, 0.30, 0.16, 0.29])
	msg(s)
	# s
end

# ╔═╡ 4104526a-4959-457b-b2c6-f6883f92b78e
#= html"""
<img src="https://upload.wikimedia.org/wikipedia/commons/d/d8/HuffmanCodeAlg.png" alt="drawing" width="300"/>
""" =#

# ╔═╡ 9bb2bc57-8964-4a6e-b533-506820810ec6
md"""
---
##### Shannon Fano Encoding Algorithm
A Shannon–Fano tree is built according to a specification designed to define an effective code table. The actual algorithm is simple:

1. For a given list of symbols, develop a corresponding list of probabilities or frequency counts so that each symbol’s relative frequency of occurrence is known

2. Sort the lists of symbols according to frequency, with the most frequently occurring symbols at the left and the least common at the right.

3. Divide the list into two parts, with the total frequency counts of the left part being as close to the total of the right as possible.

4. The left part of the list is assigned the binary digit 0, and the right part is assigned the digit 1. This means that the codes for the symbols in the first part will all start with 0, and the codes in the second part will all start with 1.

5. Recursively apply the steps 3 and 4 to each of the two halves, subdividing groups and adding bits to the codes until each symbol has become a corresponding code leaf on the tree.
---"""


# ╔═╡ Cell order:
# ╟─131bdd70-0c6b-11ec-324c-397d22bc0fc8
# ╠═7780fbf2-382c-4bce-884f-932a4e4e4cde
# ╠═e899a949-84cb-45f9-bbb8-c155fae7fe20
# ╟─b410f023-6dbf-4053-bf0e-afa76251c2fb
# ╟─1b58bc4a-6780-4c2e-94fe-b721b87d6972
# ╟─b244fa31-7d3f-437b-ba02-1edb51b66841
# ╟─27243ab6-ead5-4258-82f5-421f248d573e
# ╟─bc9c3a6d-040a-4e57-a06b-bf7ec52815bc
# ╟─18a2d6cf-ceb6-4b42-9933-9252b89937f2
# ╟─c1882359-61e9-456d-8b61-ccea75f643be
# ╟─2490492b-e2e6-42c0-b9a6-08c3ec694b5b
# ╟─2412a223-36fd-4d3f-b932-25c93cd8c1c5
# ╠═494fd53c-d15b-4b64-8494-eebcbf28179d
# ╟─f56c74e1-89a6-41d6-b3f6-8a9739aa34cf
# ╟─55e3eb24-260a-4122-a3c2-3877834bb49e
# ╟─4104526a-4959-457b-b2c6-f6883f92b78e
# ╟─9bb2bc57-8964-4a6e-b533-506820810ec6
