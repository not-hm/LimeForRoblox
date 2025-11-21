-- volcano.wtf for dumper (i'm not bothered to rewrite this, it works fine)
-- Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = 0
local v_u_4 = 64
local v_u_5 = 0
local v_u_6 = 0
local v_u_7 = buffer.create(64)
local v_u_8 = {}
local v_u_9 = 0
local v_u_10 = buffer.create(64)
local v_u_11 = {}
local v_u_12 = 0
local v_u_13 = newproxy()
local function v_u_17(p14)
	-- upvalues: (ref) v_u_6, (ref) v_u_4, (ref) v_u_7, (ref) v_u_5
	local v15 = v_u_6 + p14
	if v_u_4 < v15 then
		while v_u_4 < v15 do
			v_u_4 = v_u_4 * 1.5
		end
		local v16 = buffer.create(v_u_4)
		buffer.copy(v16, 0, v_u_7, 0, v_u_6)
		v_u_7 = v16
	end
	v_u_5 = v_u_6
	v_u_6 = v_u_6 + p14
	return v_u_5
end
local v_u_18 = table.create(256)
local v_u_19 = {
	["Reliable"] = table.create(256),
	["Unreliable"] = table.create(256)
}
local v_u_20 = {
	["Reliable"] = table.create(256),
	["Unreliable"] = table.create(256)
}
v_u_19.Reliable[0] = {}
v_u_20.Reliable[0] = table.create(256)
v_u_19.Reliable[1] = {}
v_u_20.Reliable[1] = table.create(256)
v_u_20.Reliable[2] = table.create(256)
v_u_20.Reliable[3] = {
	["head"] = nil,
	["tail"] = nil
}
v_u_20.Reliable[4] = {
	["head"] = nil,
	["tail"] = nil
}
v_u_20.Reliable[5] = {
	["head"] = nil,
	["tail"] = nil
}
v_u_20.Reliable[7] = table.create(256)
v_u_20.Reliable[8] = table.create(256)
v_u_20.Reliable[9] = table.create(256)
v_u_19.Reliable[10] = {}
v_u_20.Reliable[10] = table.create(256)
v_u_20.Unreliable[1] = table.create(256)
v_u_20.Unreliable[3] = table.create(256)
v_u_20.Reliable[13] = table.create(256)
v_u_20.Reliable[15] = table.create(256)
v_u_20.Reliable[19] = table.create(256)
v_u_20.Reliable[20] = table.create(256)
v_u_20.Reliable[21] = table.create(256)
v_u_20.Reliable[23] = table.create(256)
v_u_19.Reliable[24] = {}
v_u_20.Reliable[24] = table.create(256)
v_u_20.Reliable[25] = table.create(256)
v_u_19.Reliable[26] = {}
v_u_20.Reliable[26] = table.create(256)
v_u_20.Reliable[27] = table.create(256)
v_u_20.Reliable[28] = table.create(256)
v_u_20.Reliable[30] = table.create(256)
local function v_u_22()
	-- upvalues: (ref) v_u_12, (ref) v_u_11
	v_u_12 = v_u_12 + 1
	local v21 = v_u_11[v_u_12]
	if typeof(v21) ~= "Instance" then
		error((("Expected an Instance, got %* instead."):format((typeof(v21)))))
	end
	if not v21:IsA("Team") then
		error((("Expected an Instance of type \"Team\", got \"%*\" instead."):format(v21.ClassName)))
	end
	return v21
end
local function v_u_39()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v23 = v_u_9
	v_u_9 = v_u_9 + 3
	local v24 = v_u_10
	local v25 = v23 + 0
	if buffer.readu8(v24, v25) ~= 1 then
		error("Server encountered an error.")
	end
	local v26 = v_u_10
	local v27 = v23 + 1
	local v28 = buffer.readu16(v26, v27)
	if v28 < 0 then
		error((("Expected \"Length\" to be larger than 0, got %* instead."):format(v28)))
	end
	if v28 > 65535 then
		error((("Expected \"Length\" to be smaller than 65535, got %* instead."):format(v28)))
	end
	local v29 = table.create(v28)
	local v30 = v_u_9
	v_u_9 = v_u_9 + v28 * 2
	for _ = 1, v28 do
		local v31 = v30 + 2
		local v32 = v_u_10
		local v33 = buffer.readu16(v32, v30)
		if v33 < 0 then
			error((("Expected \"Length\" to be larger than 0, got %* instead."):format(v33)))
		end
		if v33 > 65535 then
			error((("Expected \"Length\" to be smaller than 65535, got %* instead."):format(v33)))
		end
		local v34 = table.create(v33)
		local v35 = v_u_9
		v_u_9 = v_u_9 + v33 * 8
		for _ = 1, v33 do
			local v36 = v35 + 8
			local v37 = v_u_10
			local v38 = buffer.readf64(v37, v35)
			table.insert(v34, v38)
			v35 = v36
		end
		table.insert(v29, v34)
		v30 = v31
	end
	return v29
end
local function v_u_59()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v40 = v_u_9
	v_u_9 = v_u_9 + 22
	local v41 = {}
	local v42 = v_u_10
	local v43 = v40 + 0
	v41.id = buffer.readf64(v42, v43)
	local v44 = v_u_10
	local v45 = v40 + 8
	local v46 = buffer.readu16(v44, v45)
	local v47 = buffer.readstring
	local v48 = v_u_10
	local v49 = v_u_9
	v_u_9 = v_u_9 + v46
	v41.item_name = v47(v48, v49, v46)
	local v50 = v_u_10
	local v51 = v40 + 10
	local v52 = buffer.readf32(v50, v51)
	local v53 = v_u_10
	local v54 = v40 + 14
	local v55 = buffer.readf32(v53, v54)
	local v56 = v_u_10
	local v57 = v40 + 18
	local v58 = buffer.readf32(v56, v57)
	v41.position = Vector3.new(v52, v55, v58)
	return v41
end
local function v_u_73()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v60 = v_u_9
	v_u_9 = v_u_9 + 20
	local v61 = {}
	local v62 = v_u_10
	local v63 = v60 + 0
	v61.id = buffer.readf64(v62, v63)
	local v64 = v_u_10
	local v65 = v60 + 8
	local v66 = buffer.readf32(v64, v65)
	local v67 = v_u_10
	local v68 = v60 + 12
	local v69 = buffer.readf32(v67, v68)
	local v70 = v_u_10
	local v71 = v60 + 16
	local v72 = buffer.readf32(v70, v71)
	v61.position = Vector3.new(v66, v69, v72)
	return v61
end
local function v_u_84(p74)
	-- upvalues: (copy) v_u_17, (ref) v_u_7
	local v75 = v_u_17(2)
	local v76 = v_u_7
	local v77 = v75 + 0
	buffer.writeu8(v76, v77, 6)
	if p74 == "Gamepad" then
		local v78 = v_u_7
		local v79 = v75 + 1
		buffer.writeu8(v78, v79, 0)
		return
	elseif p74 == "Mobile" then
		local v80 = v_u_7
		local v81 = v75 + 1
		buffer.writeu8(v80, v81, 1)
		return
	elseif p74 == "Computer" then
		local v82 = v_u_7
		local v83 = v75 + 1
		buffer.writeu8(v82, v83, 2)
	else
		error((("Unexpected enum: %*, expected one of \"Gamepad\" or \"Mobile\" or \"Computer\"."):format(p74)))
	end
end
local function v_u_94()
	-- upvalues: (ref) v_u_9, (ref) v_u_12, (ref) v_u_11, (ref) v_u_10
	local v85 = v_u_9
	v_u_9 = v_u_9 + 1
	local v86 = {}
	v_u_12 = v_u_12 + 1
	local v87 = v_u_11[v_u_12]
	if typeof(v87) == "Instance" then
		v_u_12 = v_u_12 - 1
		v_u_12 = v_u_12 + 1
		v86.Player = v_u_11[v_u_12]
		local v88 = v86.Player
		if typeof(v88) ~= "Instance" then
			local v89 = error
			local v90 = v86.Player
			v89((("Expected an Instance, got %* instead."):format((typeof(v90)))))
		end
		if not v86.Player:IsA("Player") then
			error((("Expected an Instance of type \"Player\", got \"%*\" instead."):format(v86.Player.ClassName)))
		end
	end
	v86.Device = true
	local v91 = v_u_10
	local v92 = v85 + 0
	local v93 = buffer.readu8(v91, v92)
	if v93 == 0 then
		v86.Device = "Gamepad"
		return v86
	elseif v93 == 1 then
		v86.Device = "Mobile"
		return v86
	elseif v93 == 2 then
		v86.Device = "Computer"
		return v86
	else
		error((("Unexpected enum: %*"):format(v93)))
		return v86
	end
end
local function v_u_105()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v95 = v_u_9
	v_u_9 = v_u_9 + 2
	local v96 = v_u_10
	local v97 = v95 + 0
	if buffer.readu8(v96, v97) ~= 1 then
		error("Server encountered an error.")
	end
	local v98 = v_u_10
	local v99 = v95 + 1
	local v100
	if buffer.readu8(v98, v99) == 1 then
		local v101 = v_u_9
		v_u_9 = v_u_9 + 1
		v100 = true
		local v102 = v_u_10
		local v103 = v101 + 0
		local v104 = buffer.readu8(v102, v103)
		if v104 == 0 then
			return "Gamepad"
		end
		if v104 == 1 then
			return "Mobile"
		end
		if v104 == 2 then
			return "Computer"
		end
		error((("Unexpected enum: %*"):format(v104)))
	else
		v100 = nil
	end
	return v100
end
local function v_u_179(p106)
	-- upvalues: (copy) v_u_17, (ref) v_u_7
	local v107 = v_u_17(7)
	local v108 = v_u_7
	local v109 = v107 + 0
	buffer.writeu8(v108, v109, 0)
	if p106.X > 65504 then
		local v110 = v_u_7
		local v111 = v107 + 1
		buffer.writeu16(v110, v111, 31744)
	elseif p106.X < -65504 then
		local v112 = v_u_7
		local v113 = v107 + 1
		buffer.writeu16(v112, v113, 64512)
	elseif p106.X == p106.X then
		if p106.X == 0 then
			local v114 = v_u_7
			local v115 = v107 + 1
			buffer.writeu16(v114, v115, 0)
		else
			local v116 = p106.X
			local v117 = math.abs(v116)
			local v118 = math.log(v117, 2)
			local v119 = math.floor(v118) - 10
			local v120 = math.ldexp(1, v119)
			local v121 = v117 // v120 * v120
			local v122, v123 = math.frexp(v121)
			local v124 = v123 + 14
			local v125
			if v124 <= 0 then
				local v126 = v122 * 1024
				local v127 = math.abs(v124)
				v125 = v126 / math.ldexp(1, v127)
			else
				v125 = v122 * 2048
			end
			local v128 = math.round(v125) % 1024 + math.max(v124, 0) * 1024 + (v116 < 0 and 32768 or 0)
			local v129 = v_u_7
			local v130 = v107 + 1
			buffer.writeu16(v129, v130, v128)
		end
	else
		local v131 = v_u_7
		local v132 = v107 + 1
		buffer.writeu16(v131, v132, 64513)
	end
	if p106.Y > 65504 then
		local v133 = v_u_7
		local v134 = v107 + 3
		buffer.writeu16(v133, v134, 31744)
	elseif p106.Y < -65504 then
		local v135 = v_u_7
		local v136 = v107 + 3
		buffer.writeu16(v135, v136, 64512)
	elseif p106.Y == p106.Y then
		if p106.Y == 0 then
			local v137 = v_u_7
			local v138 = v107 + 3
			buffer.writeu16(v137, v138, 0)
		else
			local v139 = p106.Y
			local v140 = math.abs(v139)
			local v141 = math.log(v140, 2)
			local v142 = math.floor(v141) - 10
			local v143 = math.ldexp(1, v142)
			local v144 = v140 // v143 * v143
			local v145, v146 = math.frexp(v144)
			local v147 = v146 + 14
			local v148
			if v147 <= 0 then
				local v149 = v145 * 1024
				local v150 = math.abs(v147)
				v148 = v149 / math.ldexp(1, v150)
			else
				v148 = v145 * 2048
			end
			local v151 = math.round(v148) % 1024 + math.max(v147, 0) * 1024 + (v139 < 0 and 32768 or 0)
			local v152 = v_u_7
			local v153 = v107 + 3
			buffer.writeu16(v152, v153, v151)
		end
	else
		local v154 = v_u_7
		local v155 = v107 + 3
		buffer.writeu16(v154, v155, 64513)
	end
	if p106.Z > 65504 then
		local v156 = v_u_7
		local v157 = v107 + 5
		buffer.writeu16(v156, v157, 31744)
		return
	elseif p106.Z < -65504 then
		local v158 = v_u_7
		local v159 = v107 + 5
		buffer.writeu16(v158, v159, 64512)
		return
	elseif p106.Z == p106.Z then
		if p106.Z == 0 then
			local v160 = v_u_7
			local v161 = v107 + 5
			buffer.writeu16(v160, v161, 0)
		else
			local v162 = p106.Z
			local v163 = math.abs(v162)
			local v164 = math.log(v163, 2)
			local v165 = math.floor(v164) - 10
			local v166 = math.ldexp(1, v165)
			local v167 = v163 // v166 * v166
			local v168, v169 = math.frexp(v167)
			local v170 = v169 + 14
			local v171
			if v170 <= 0 then
				local v172 = v168 * 1024
				local v173 = math.abs(v170)
				v171 = v172 / math.ldexp(1, v173)
			else
				v171 = v168 * 2048
			end
			local v174 = math.round(v171) % 1024 + math.max(v170, 0) * 1024 + (v162 < 0 and 32768 or 0)
			local v175 = v_u_7
			local v176 = v107 + 5
			buffer.writeu16(v175, v176, v174)
		end
	else
		local v177 = v_u_7
		local v178 = v107 + 5
		buffer.writeu16(v177, v178, 64513)
		return
	end
end
local function v_u_213()
	-- upvalues: (ref) v_u_9, (ref) v_u_12, (ref) v_u_11, (ref) v_u_10
	local v180 = v_u_9
	v_u_9 = v_u_9 + 6
	local v181 = {}
	v_u_12 = v_u_12 + 1
	local v182 = v_u_11[v_u_12]
	if typeof(v182) == "Instance" then
		v_u_12 = v_u_12 - 1
		v_u_12 = v_u_12 + 1
		v181.character = v_u_11[v_u_12]
		local v183 = v181.character
		if typeof(v183) ~= "Instance" then
			local v184 = error
			local v185 = v181.character
			v184((("Expected an Instance, got %* instead."):format((typeof(v185)))))
		end
		if not v181.character:IsA("Model") then
			error((("Expected an Instance of type \"Model\", got \"%*\" instead."):format(v181.character.ClassName)))
		end
	end
	local v186 = v_u_10
	local v187 = v180 + 0
	local v188 = buffer.readu16(v186, v187)
	local v189 = v188 % 32768
	local v190
	if v189 == 31744 then
		v190 = v188 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v189 == 64512 then
		v190 = (0 / 0)
	elseif v189 == 0 then
		v190 = 0
	else
		local v191 = v189 % 1024
		local v192 = v189 // 1024
		local v193
		if v192 == 0 then
			v193 = v191 / 1024
		else
			v193 = v191 / 2048 + 0.5
		end
		local v194 = v192 - 14
		v190 = math.ldexp(v193, v194)
		if v188 // 32768 == 1 then
			v190 = -v190
		end
	end
	local v195 = v_u_10
	local v196 = v180 + 2
	local v197 = buffer.readu16(v195, v196)
	local v198 = v197 % 32768
	local v199
	if v198 == 31744 then
		v199 = v197 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v198 == 64512 then
		v199 = (0 / 0)
	elseif v198 == 0 then
		v199 = 0
	else
		local v200 = v198 % 1024
		local v201 = v198 // 1024
		local v202
		if v201 == 0 then
			v202 = v200 / 1024
		else
			v202 = v200 / 2048 + 0.5
		end
		local v203 = v201 - 14
		v199 = math.ldexp(v202, v203)
		if v197 // 32768 == 1 then
			v199 = -v199
		end
	end
	local v204 = v_u_10
	local v205 = v180 + 4
	local v206 = buffer.readu16(v204, v205)
	local v207 = v206 % 32768
	local v208
	if v207 == 31744 then
		v208 = v206 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v207 == 64512 then
		v208 = (0 / 0)
	elseif v207 == 0 then
		v208 = 0
	else
		local v209 = v207 % 1024
		local v210 = v207 // 1024
		local v211
		if v210 == 0 then
			v211 = v209 / 1024
		else
			v211 = v209 / 2048 + 0.5
		end
		local v212 = v210 - 14
		v208 = math.ldexp(v211, v212)
		if v206 // 32768 == 1 then
			v208 = -v208
		end
	end
	v181.rotation = Vector3.new(v190, v199, v208)
	return v181
end
local function v_u_363(p214, p215)
	-- upvalues: (copy) v_u_17, (ref) v_u_7
	local v216 = v_u_17(14)
	local v217 = v_u_7
	local v218 = v216 + 0
	buffer.writeu8(v217, v218, 2)
	local v219 = p214.Position
	if v219.X > 65504 then
		local v220 = v_u_7
		local v221 = v216 + 1
		buffer.writeu16(v220, v221, 31744)
	elseif v219.X < -65504 then
		local v222 = v_u_7
		local v223 = v216 + 1
		buffer.writeu16(v222, v223, 64512)
	elseif v219.X == v219.X then
		if v219.X == 0 then
			local v224 = v_u_7
			local v225 = v216 + 1
			buffer.writeu16(v224, v225, 0)
		else
			local v226 = v219.X
			local v227 = math.abs(v226)
			local v228 = math.log(v227, 2)
			local v229 = math.floor(v228) - 10
			local v230 = math.ldexp(1, v229)
			local v231 = v227 // v230 * v230
			local v232, v233 = math.frexp(v231)
			local v234 = v233 + 14
			local v235
			if v234 <= 0 then
				local v236 = v232 * 1024
				local v237 = math.abs(v234)
				v235 = v236 / math.ldexp(1, v237)
			else
				v235 = v232 * 2048
			end
			local v238 = math.round(v235) % 1024 + math.max(v234, 0) * 1024 + (v226 < 0 and 32768 or 0)
			local v239 = v_u_7
			local v240 = v216 + 1
			buffer.writeu16(v239, v240, v238)
		end
	else
		local v241 = v_u_7
		local v242 = v216 + 1
		buffer.writeu16(v241, v242, 64513)
	end
	if v219.Y > 65504 then
		local v243 = v_u_7
		local v244 = v216 + 3
		buffer.writeu16(v243, v244, 31744)
	elseif v219.Y < -65504 then
		local v245 = v_u_7
		local v246 = v216 + 3
		buffer.writeu16(v245, v246, 64512)
	elseif v219.Y == v219.Y then
		if v219.Y == 0 then
			local v247 = v_u_7
			local v248 = v216 + 3
			buffer.writeu16(v247, v248, 0)
		else
			local v249 = v219.Y
			local v250 = math.abs(v249)
			local v251 = math.log(v250, 2)
			local v252 = math.floor(v251) - 10
			local v253 = math.ldexp(1, v252)
			local v254 = v250 // v253 * v253
			local v255, v256 = math.frexp(v254)
			local v257 = v256 + 14
			local v258
			if v257 <= 0 then
				local v259 = v255 * 1024
				local v260 = math.abs(v257)
				v258 = v259 / math.ldexp(1, v260)
			else
				v258 = v255 * 2048
			end
			local v261 = math.round(v258) % 1024 + math.max(v257, 0) * 1024 + (v249 < 0 and 32768 or 0)
			local v262 = v_u_7
			local v263 = v216 + 3
			buffer.writeu16(v262, v263, v261)
		end
	else
		local v264 = v_u_7
		local v265 = v216 + 3
		buffer.writeu16(v264, v265, 64513)
	end
	if v219.Z > 65504 then
		local v266 = v_u_7
		local v267 = v216 + 5
		buffer.writeu16(v266, v267, 31744)
	elseif v219.Z < -65504 then
		local v268 = v_u_7
		local v269 = v216 + 5
		buffer.writeu16(v268, v269, 64512)
	elseif v219.Z == v219.Z then
		if v219.Z == 0 then
			local v270 = v_u_7
			local v271 = v216 + 5
			buffer.writeu16(v270, v271, 0)
		else
			local v272 = v219.Z
			local v273 = math.abs(v272)
			local v274 = math.log(v273, 2)
			local v275 = math.floor(v274) - 10
			local v276 = math.ldexp(1, v275)
			local v277 = v273 // v276 * v276
			local v278, v279 = math.frexp(v277)
			local v280 = v279 + 14
			local v281
			if v280 <= 0 then
				local v282 = v278 * 1024
				local v283 = math.abs(v280)
				v281 = v282 / math.ldexp(1, v283)
			else
				v281 = v278 * 2048
			end
			local v284 = math.round(v281) % 1024 + math.max(v280, 0) * 1024 + (v272 < 0 and 32768 or 0)
			local v285 = v_u_7
			local v286 = v216 + 5
			buffer.writeu16(v285, v286, v284)
		end
	else
		local v287 = v_u_7
		local v288 = v216 + 5
		buffer.writeu16(v287, v288, 64513)
	end
	local v289, v290, v291 = p214:ToOrientation()
	if v289 > 65504 then
		local v292 = v_u_7
		local v293 = v216 + 7
		buffer.writeu16(v292, v293, 31744)
	elseif v289 < -65504 then
		local v294 = v_u_7
		local v295 = v216 + 7
		buffer.writeu16(v294, v295, 64512)
	elseif v289 == v289 then
		if v289 == 0 then
			local v296 = v_u_7
			local v297 = v216 + 7
			buffer.writeu16(v296, v297, 0)
		else
			local v298 = math.abs(v289)
			local v299 = math.log(v298, 2)
			local v300 = math.floor(v299) - 10
			local v301 = math.ldexp(1, v300)
			local v302 = v298 // v301 * v301
			local v303, v304 = math.frexp(v302)
			local v305 = v304 + 14
			local v306
			if v305 <= 0 then
				local v307 = v303 * 1024
				local v308 = math.abs(v305)
				v306 = v307 / math.ldexp(1, v308)
			else
				v306 = v303 * 2048
			end
			local v309 = math.round(v306) % 1024 + math.max(v305, 0) * 1024 + (v289 < 0 and 32768 or 0)
			local v310 = v_u_7
			local v311 = v216 + 7
			buffer.writeu16(v310, v311, v309)
		end
	else
		local v312 = v_u_7
		local v313 = v216 + 7
		buffer.writeu16(v312, v313, 64513)
	end
	if v290 > 65504 then
		local v314 = v_u_7
		local v315 = v216 + 9
		buffer.writeu16(v314, v315, 31744)
	elseif v290 < -65504 then
		local v316 = v_u_7
		local v317 = v216 + 9
		buffer.writeu16(v316, v317, 64512)
	elseif v290 == v290 then
		if v290 == 0 then
			local v318 = v_u_7
			local v319 = v216 + 9
			buffer.writeu16(v318, v319, 0)
		else
			local v320 = math.abs(v290)
			local v321 = math.log(v320, 2)
			local v322 = math.floor(v321) - 10
			local v323 = math.ldexp(1, v322)
			local v324 = v320 // v323 * v323
			local v325, v326 = math.frexp(v324)
			local v327 = v326 + 14
			local v328
			if v327 <= 0 then
				local v329 = v325 * 1024
				local v330 = math.abs(v327)
				v328 = v329 / math.ldexp(1, v330)
			else
				v328 = v325 * 2048
			end
			local v331 = math.round(v328) % 1024 + math.max(v327, 0) * 1024 + (v290 < 0 and 32768 or 0)
			local v332 = v_u_7
			local v333 = v216 + 9
			buffer.writeu16(v332, v333, v331)
		end
	else
		local v334 = v_u_7
		local v335 = v216 + 9
		buffer.writeu16(v334, v335, 64513)
	end
	if v291 > 65504 then
		local v336 = v_u_7
		local v337 = v216 + 11
		buffer.writeu16(v336, v337, 31744)
	elseif v291 < -65504 then
		local v338 = v_u_7
		local v339 = v216 + 11
		buffer.writeu16(v338, v339, 64512)
	elseif v291 == v291 then
		if v291 == 0 then
			local v340 = v_u_7
			local v341 = v216 + 11
			buffer.writeu16(v340, v341, 0)
		else
			local v342 = math.abs(v291)
			local v343 = math.log(v342, 2)
			local v344 = math.floor(v343) - 10
			local v345 = math.ldexp(1, v344)
			local v346 = v342 // v345 * v345
			local v347, v348 = math.frexp(v346)
			local v349 = v348 + 14
			local v350
			if v349 <= 0 then
				local v351 = v347 * 1024
				local v352 = math.abs(v349)
				v350 = v351 / math.ldexp(1, v352)
			else
				v350 = v347 * 2048
			end
			local v353 = math.round(v350) % 1024 + math.max(v349, 0) * 1024 + (v291 < 0 and 32768 or 0)
			local v354 = v_u_7
			local v355 = v216 + 11
			buffer.writeu16(v354, v355, v353)
		end
	else
		local v356 = v_u_7
		local v357 = v216 + 11
		buffer.writeu16(v356, v357, 64513)
	end
	local v358 = v_u_7
	local v359 = v216 + 13
	local v360 = p215 == nil and 0 or 1
	buffer.writeu8(v358, v359, v360)
	if p215 ~= nil then
		local v361 = v_u_7
		local v362 = v_u_17(1) + 0
		buffer.writeu8(v361, v362, p215 and 1 or 0)
	end
end
local function v_u_425()
	-- upvalues: (ref) v_u_9, (ref) v_u_12, (ref) v_u_11, (ref) v_u_10
	local v364 = v_u_9
	v_u_9 = v_u_9 + 12
	local v365 = {}
	v_u_12 = v_u_12 + 1
	local v366 = v_u_11[v_u_12]
	if typeof(v366) == "Instance" then
		v_u_12 = v_u_12 - 1
		v_u_12 = v_u_12 + 1
		v365.player = v_u_11[v_u_12]
		local v367 = v365.player
		if typeof(v367) ~= "Instance" then
			local v368 = error
			local v369 = v365.player
			v368((("Expected an Instance, got %* instead."):format((typeof(v369)))))
		end
		if not v365.player:IsA("Player") then
			error((("Expected an Instance of type \"Player\", got \"%*\" instead."):format(v365.player.ClassName)))
		end
	end
	local v370 = v_u_10
	local v371 = v364 + 0
	local v372 = buffer.readu16(v370, v371)
	local v373 = v372 % 32768
	local v374
	if v373 == 31744 then
		v374 = v372 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v373 == 64512 then
		v374 = (0 / 0)
	elseif v373 == 0 then
		v374 = 0
	else
		local v375 = v373 % 1024
		local v376 = v373 // 1024
		local v377
		if v376 == 0 then
			v377 = v375 / 1024
		else
			v377 = v375 / 2048 + 0.5
		end
		local v378 = v376 - 14
		v374 = math.ldexp(v377, v378)
		if v372 // 32768 == 1 then
			v374 = -v374
		end
	end
	local v379 = v_u_10
	local v380 = v364 + 2
	local v381 = buffer.readu16(v379, v380)
	local v382 = v381 % 32768
	local v383
	if v382 == 31744 then
		v383 = v381 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v382 == 64512 then
		v383 = (0 / 0)
	elseif v382 == 0 then
		v383 = 0
	else
		local v384 = v382 % 1024
		local v385 = v382 // 1024
		local v386
		if v385 == 0 then
			v386 = v384 / 1024
		else
			v386 = v384 / 2048 + 0.5
		end
		local v387 = v385 - 14
		v383 = math.ldexp(v386, v387)
		if v381 // 32768 == 1 then
			v383 = -v383
		end
	end
	local v388 = v_u_10
	local v389 = v364 + 4
	local v390 = buffer.readu16(v388, v389)
	local v391 = v390 % 32768
	local v392
	if v391 == 31744 then
		v392 = v390 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v391 == 64512 then
		v392 = (0 / 0)
	elseif v391 == 0 then
		v392 = 0
	else
		local v393 = v391 % 1024
		local v394 = v391 // 1024
		local v395
		if v394 == 0 then
			v395 = v393 / 1024
		else
			v395 = v393 / 2048 + 0.5
		end
		local v396 = v394 - 14
		v392 = math.ldexp(v395, v396)
		if v390 // 32768 == 1 then
			v392 = -v392
		end
	end
	local v397 = Vector3.new(v374, v383, v392)
	local v398 = v_u_10
	local v399 = v364 + 6
	local v400 = buffer.readu16(v398, v399)
	local v401 = v400 % 32768
	local v402
	if v401 == 31744 then
		v402 = v400 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v401 == 64512 then
		v402 = (0 / 0)
	elseif v401 == 0 then
		v402 = 0
	else
		local v403 = v401 % 1024
		local v404 = v401 // 1024
		local v405
		if v404 == 0 then
			v405 = v403 / 1024
		else
			v405 = v403 / 2048 + 0.5
		end
		local v406 = v404 - 14
		v402 = math.ldexp(v405, v406)
		if v400 // 32768 == 1 then
			v402 = -v402
		end
	end
	local v407 = v_u_10
	local v408 = v364 + 8
	local v409 = buffer.readu16(v407, v408)
	local v410 = v409 % 32768
	local v411
	if v410 == 31744 then
		v411 = v409 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v410 == 64512 then
		v411 = (0 / 0)
	elseif v410 == 0 then
		v411 = 0
	else
		local v412 = v410 % 1024
		local v413 = v410 // 1024
		local v414
		if v413 == 0 then
			v414 = v412 / 1024
		else
			v414 = v412 / 2048 + 0.5
		end
		local v415 = v413 - 14
		v411 = math.ldexp(v414, v415)
		if v409 // 32768 == 1 then
			v411 = -v411
		end
	end
	local v416 = v_u_10
	local v417 = v364 + 10
	local v418 = buffer.readu16(v416, v417)
	local v419 = v418 % 32768
	local v420
	if v419 == 31744 then
		v420 = v418 // 32768 == 1 and (-1 / 0) or (1 / 0)
	elseif v419 == 64512 then
		v420 = (0 / 0)
	elseif v419 == 0 then
		v420 = 0
	else
		local v421 = v419 % 1024
		local v422 = v419 // 1024
		local v423
		if v422 == 0 then
			v423 = v421 / 1024
		else
			v423 = v421 / 2048 + 0.5
		end
		local v424 = v422 - 14
		v420 = math.ldexp(v423, v424)
		if v418 // 32768 == 1 then
			v420 = -v420
		end
	end
	v365.rotation = CFrame.new(v397) * CFrame.fromOrientation(v402, v411, v420)
	return v365
end
local function v_u_433(p426)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v427 = v_u_17(3)
	local v428 = v_u_7
	local v429 = v427 + 0
	buffer.writeu8(v428, v429, 18)
	local v430 = #p426
	local v431 = v_u_7
	local v432 = v427 + 1
	buffer.writeu16(v431, v432, v430)
	v_u_17(v430)
	buffer.writestring(v_u_7, v_u_5, p426, v430)
end
local function v_u_450(p434, p435)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v436 = v_u_17(5)
	local v437 = v_u_7
	local v438 = v436 + 0
	buffer.writeu8(v437, v438, 19)
	local v439 = v_u_7
	local v440 = v436 + 1
	buffer.writeu8(v439, v440, p435)
	local v441 = #p434.item
	local v442 = v_u_7
	local v443 = v436 + 2
	buffer.writeu16(v442, v443, v441)
	v_u_17(v441)
	buffer.writestring(v_u_7, v_u_5, p434.item, v441)
	local v444 = v_u_7
	local v445 = v436 + 4
	local v446 = p434.tier == nil and 0 or 1
	buffer.writeu8(v444, v445, v446)
	if p434.tier ~= nil then
		local v447 = v_u_7
		local v448 = v_u_17(1) + 0
		local v449 = p434.tier
		buffer.writeu8(v447, v448, v449)
	end
end
local function v_u_461(p451, p452)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v453 = v_u_17(4)
	local v454 = v_u_7
	local v455 = v453 + 0
	buffer.writeu8(v454, v455, 20)
	local v456 = v_u_7
	local v457 = v453 + 1
	buffer.writeu8(v456, v457, p452)
	local v458 = #p451
	local v459 = v_u_7
	local v460 = v453 + 2
	buffer.writeu16(v459, v460, v458)
	v_u_17(v458)
	buffer.writestring(v_u_7, v_u_5, p451, v458)
end
local function v_u_484()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v462 = v_u_9
	v_u_9 = v_u_9 + 2
	local v463 = v_u_10
	local v464 = v462 + 0
	local v465 = buffer.readu16(v463, v464)
	if v465 < 0 then
		error((("Expected \"Length\" to be larger than 0, got %* instead."):format(v465)))
	end
	if v465 > 65535 then
		error((("Expected \"Length\" to be smaller than 65535, got %* instead."):format(v465)))
	end
	local v466 = table.create(v465)
	local v467 = v_u_9
	v_u_9 = v_u_9 + v465 * 6
	for _ = 1, v465 do
		local v468 = {}
		local v469 = v467 + 2
		local v470 = v_u_10
		local v471 = buffer.readu16(v470, v467)
		local v472 = buffer.readstring
		local v473 = v_u_10
		local v474 = v_u_9
		v_u_9 = v_u_9 + v471
		v468.Type = v472(v473, v474, v471)
		local v475 = v469 + 1
		local v476 = v_u_10
		v468.Elo = buffer.readu8(v476, v469)
		local v477 = v475 + 1
		local v478 = v_u_10
		v468.Season = buffer.readu8(v478, v475)
		v467 = v477 + 2
		local v479 = v_u_10
		local v480 = buffer.readu16(v479, v477)
		local v481 = buffer.readstring
		local v482 = v_u_10
		local v483 = v_u_9
		v_u_9 = v_u_9 + v480
		v468.Mode = v481(v482, v483, v480)
		table.insert(v466, v468)
	end
	return v466
end
local function v_u_495(p485)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v486 = v_u_17(5)
	local v487 = v_u_7
	local v488 = v486 + 0
	buffer.writeu8(v487, v488, 22)
	local v489 = #p485.player_name
	local v490 = v_u_7
	local v491 = v486 + 1
	buffer.writeu16(v490, v491, v489)
	v_u_17(v489)
	buffer.writestring(v_u_7, v_u_5, p485.player_name, v489)
	local v492 = #p485.pass_id
	local v493 = v_u_7
	local v494 = v486 + 3
	buffer.writeu16(v493, v494, v492)
	v_u_17(v492)
	buffer.writestring(v_u_7, v_u_5, p485.pass_id, v492)
end
local function v_u_516()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v496 = v_u_9
	v_u_9 = v_u_9 + 2
	local v497 = {}
	local v498 = v_u_10
	local v499 = v496 + 0
	if buffer.readu8(v498, v499) == 1 then
		local v500 = v_u_9
		v_u_9 = v_u_9 + 2
		local v501 = v_u_10
		local v502 = v500 + 0
		local v503 = buffer.readu16(v501, v502)
		local v504 = buffer.readstring
		local v505 = v_u_10
		local v506 = v_u_9
		v_u_9 = v_u_9 + v503
		v497.id = v504(v505, v506, v503)
	end
	local v507 = v_u_10
	local v508 = v496 + 1
	if buffer.readu8(v507, v508) == 1 then
		local v509 = v_u_9
		v_u_9 = v_u_9 + 2
		local v510 = v_u_10
		local v511 = v509 + 0
		local v512 = buffer.readu16(v510, v511)
		local v513 = buffer.readstring
		local v514 = v_u_10
		local v515 = v_u_9
		v_u_9 = v_u_9 + v512
		v497.error_message = v513(v514, v515, v512)
	end
	return v497
end
local function v_u_527(p517, p518)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v519 = v_u_17(4)
	local v520 = v_u_7
	local v521 = v519 + 0
	buffer.writeu8(v520, v521, 27)
	local v522 = v_u_7
	local v523 = v519 + 1
	buffer.writeu8(v522, v523, p518)
	local v524 = #p517
	local v525 = v_u_7
	local v526 = v519 + 2
	buffer.writeu16(v525, v526, v524)
	v_u_17(v524)
	buffer.writestring(v_u_7, v_u_5, p517, v524)
end
local function v_u_546()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v528 = v_u_9
	v_u_9 = v_u_9 + 2
	local v529 = v_u_10
	local v530 = v528 + 0
	if buffer.readu8(v529, v530) ~= 1 then
		error("Server encountered an error.")
	end
	local v531 = v_u_10
	local v532 = v528 + 1
	local v533 = buffer.readu8(v531, v532)
	if v533 < 0 then
		error((("Expected \"Length\" to be larger than 0, got %* instead."):format(v533)))
	end
	if v533 > 50 then
		error((("Expected \"Length\" to be smaller than 50, got %* instead."):format(v533)))
	end
	local v534 = table.create(v533)
	local v535 = v_u_9
	v_u_9 = v_u_9 + v533 * 18
	for _ = 1, v533 do
		local v536 = {}
		local v537 = v535 + 8
		local v538 = v_u_10
		v536.userId = buffer.readf64(v538, v535)
		local v539 = v537 + 2
		local v540 = v_u_10
		local v541 = buffer.readu16(v540, v537)
		local v542 = buffer.readstring
		local v543 = v_u_10
		local v544 = v_u_9
		v_u_9 = v_u_9 + v541
		v536.countryCode = v542(v543, v544, v541)
		v535 = v539 + 8
		local v545 = v_u_10
		v536.value = buffer.readf64(v545, v539)
		table.insert(v534, v536)
	end
	return v534
end
local function v_u_563()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v547 = v_u_9
	v_u_9 = v_u_9 + 2
	local v548 = v_u_10
	local v549 = v547 + 0
	if buffer.readu8(v548, v549) ~= 1 then
		error("Server encountered an error.")
	end
	local v550 = v_u_10
	local v551 = v547 + 1
	local v552 = buffer.readu8(v550, v551)
	if v552 < 0 then
		error((("Expected \"Length\" to be larger than 0, got %* instead."):format(v552)))
	end
	if v552 > 50 then
		error((("Expected \"Length\" to be smaller than 50, got %* instead."):format(v552)))
	end
	local v553 = table.create(v552)
	local v554 = v_u_9
	v_u_9 = v_u_9 + v552 * 10
	for _ = 1, v552 do
		local v555 = {}
		local v556 = v554 + 2
		local v557 = v_u_10
		local v558 = buffer.readu16(v557, v554)
		local v559 = buffer.readstring
		local v560 = v_u_10
		local v561 = v_u_9
		v_u_9 = v_u_9 + v558
		v555.guild = v559(v560, v561, v558)
		v554 = v556 + 8
		local v562 = v_u_10
		v555.value = buffer.readf64(v562, v556)
		table.insert(v553, v555)
	end
	return v553
end
local function v_u_611(p564)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5, (ref) v_u_8, (copy) v_u_13
	local v565 = v_u_17(10)
	local v566 = v_u_7
	local v567 = v565 + 0
	buffer.writeu8(v566, v567, 29)
	local v568 = v_u_7
	local v569 = v565 + 1
	local v570 = p564.target_entity_id
	buffer.writeu16(v568, v569, v570)
	local v571 = v_u_7
	local v572 = v565 + 3
	local v573 = p564.is_crit and 1 or 0
	buffer.writeu8(v571, v572, v573)
	local v574 = #p564.weapon_name
	local v575 = v_u_7
	local v576 = v565 + 4
	buffer.writeu16(v575, v576, v574)
	v_u_17(v574)
	buffer.writestring(v_u_7, v_u_5, p564.weapon_name, v574)
	local v577 = v_u_7
	local v578 = v565 + 6
	local v579 = p564.sigma == nil and 0 or 1
	buffer.writeu8(v577, v578, v579)
	if p564.sigma ~= nil then
		local v580 = v_u_17(2)
		local v581 = #p564.sigma
		local v582 = v_u_7
		local v583 = v580 + 0
		buffer.writeu16(v582, v583, v581)
		v_u_17(v581)
		buffer.writestring(v_u_7, v_u_5, p564.sigma, v581)
	end
	local v584 = v_u_7
	local v585 = v565 + 7
	local v586 = p564.rizz == nil and 0 or 1
	buffer.writeu8(v584, v585, v586)
	if p564.rizz ~= nil then
		local v587 = v_u_17(2)
		local v588 = #p564.rizz
		local v589 = v_u_7
		local v590 = v587 + 0
		buffer.writeu16(v589, v590, v588)
		v_u_17(v588)
		buffer.writestring(v_u_7, v_u_5, p564.rizz, v588)
	end
	local v591 = v_u_7
	local v592 = v565 + 8
	local v593 = p564.those == nil and 0 or 1
	buffer.writeu8(v591, v592, v593)
	if p564.those ~= nil then
		local v594 = v_u_7
		local v595 = v_u_17(1) + 0
		local v596 = p564.those and 1 or 0
		buffer.writeu8(v594, v595, v596)
	end
	local v597 = v_u_7
	local v598 = v565 + 9
	local v599 = p564.extra == nil and 0 or 1
	buffer.writeu8(v597, v598, v599)
	if p564.extra ~= nil then
		local v600 = v_u_17(2)
		local v601 = 0
		for v602, v608 in p564.extra do
			v601 = v601 + 1
			local v604 = #v602
			local v605 = v_u_17(2)
			local v606 = v_u_7
			buffer.writeu16(v606, v605, v604)
			v_u_17(v604)
			buffer.writestring(v_u_7, v_u_5, v602, v604)
			local v607 = v_u_8
			if v608 == nil then
				local v608 = v_u_13
			end
			table.insert(v607, v608)
		end
		local v609 = v_u_7
		local v610 = v600 + 0
		buffer.writeu16(v609, v610, v601)
	end
end
local function v_u_666(p612, p613)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5, (ref) v_u_8, (copy) v_u_13
	local v614 = v_u_17(20)
	local v615 = v_u_7
	local v616 = v614 + 0
	buffer.writeu8(v615, v616, 30)
	local v617 = v_u_7
	local v618 = v614 + 1
	buffer.writeu8(v617, v618, p613)
	local v619 = p612.position
	local v620 = v_u_7
	local v621 = v614 + 2
	local v622 = v619.X
	buffer.writef32(v620, v621, v622)
	local v623 = v_u_7
	local v624 = v614 + 6
	local v625 = v619.Y
	buffer.writef32(v623, v624, v625)
	local v626 = v_u_7
	local v627 = v614 + 10
	local v628 = v619.Z
	buffer.writef32(v626, v627, v628)
	local v629 = #p612.block_type
	local v630 = v_u_7
	local v631 = v614 + 14
	buffer.writeu16(v630, v631, v629)
	v_u_17(v629)
	buffer.writestring(v_u_7, v_u_5, p612.block_type, v629)
	local v632 = v_u_7
	local v633 = v614 + 16
	local v634 = p612.sigma == nil and 0 or 1
	buffer.writeu8(v632, v633, v634)
	if p612.sigma ~= nil then
		local v635 = v_u_17(2)
		local v636 = #p612.sigma
		local v637 = v_u_7
		local v638 = v635 + 0
		buffer.writeu16(v637, v638, v636)
		v_u_17(v636)
		buffer.writestring(v_u_7, v_u_5, p612.sigma, v636)
	end
	local v639 = v_u_7
	local v640 = v614 + 17
	local v641 = p612.rizz == nil and 0 or 1
	buffer.writeu8(v639, v640, v641)
	if p612.rizz ~= nil then
		local v642 = v_u_17(2)
		local v643 = #p612.rizz
		local v644 = v_u_7
		local v645 = v642 + 0
		buffer.writeu16(v644, v645, v643)
		v_u_17(v643)
		buffer.writestring(v_u_7, v_u_5, p612.rizz, v643)
	end
	local v646 = v_u_7
	local v647 = v614 + 18
	local v648 = p612.those == nil and 0 or 1
	buffer.writeu8(v646, v647, v648)
	if p612.those ~= nil then
		local v649 = v_u_7
		local v650 = v_u_17(1) + 0
		local v651 = p612.those and 1 or 0
		buffer.writeu8(v649, v650, v651)
	end
	local v652 = v_u_7
	local v653 = v614 + 19
	local v654 = p612.extra == nil and 0 or 1
	buffer.writeu8(v652, v653, v654)
	if p612.extra ~= nil then
		local v655 = v_u_17(2)
		local v656 = 0
		for v657, v663 in p612.extra do
			v656 = v656 + 1
			local v659 = #v657
			local v660 = v_u_17(2)
			local v661 = v_u_7
			buffer.writeu16(v661, v660, v659)
			v_u_17(v659)
			buffer.writestring(v_u_7, v_u_5, v657, v659)
			local v662 = v_u_8
			if v663 == nil then
				local v663 = v_u_13
			end
			table.insert(v662, v663)
		end
		local v664 = v_u_7
		local v665 = v655 + 0
		buffer.writeu16(v664, v665, v656)
	end
end
local function v_u_679()
	-- upvalues: (ref) v_u_9, (ref) v_u_10
	local v667 = v_u_9
	v_u_9 = v_u_9 + 3
	local v668 = v_u_10
	local v669 = v667 + 0
	if buffer.readu8(v668, v669) ~= 1 then
		error("Server encountered an error.")
	end
	local v670 = v_u_10
	local v671 = v667 + 1
	local v672 = buffer.readu8(v670, v671) == 1
	local v673 = v_u_10
	local v674 = v667 + 2
	local v675
	if buffer.readu8(v673, v674) == 1 then
		local v676 = v_u_9
		v_u_9 = v_u_9 + 1
		local v677 = v_u_10
		local v678 = v676 + 0
		v675 = buffer.readu8(v677, v678) == 1
	else
		v675 = nil
	end
	return v672, v675
end
local function v_u_700(p680)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v681 = v_u_17(23)
	local v682 = v_u_7
	local v683 = v681 + 0
	buffer.writeu8(v682, v683, 31)
	local v684 = p680.position
	local v685 = v_u_7
	local v686 = v681 + 1
	local v687 = v684.X
	buffer.writef32(v685, v686, v687)
	local v688 = v_u_7
	local v689 = v681 + 5
	local v690 = v684.Y
	buffer.writef32(v688, v689, v690)
	local v691 = v_u_7
	local v692 = v681 + 9
	local v693 = v684.Z
	buffer.writef32(v691, v692, v693)
	local v694 = #p680.pickaxe_name
	local v695 = v_u_7
	local v696 = v681 + 13
	buffer.writeu16(v695, v696, v694)
	v_u_17(v694)
	buffer.writestring(v_u_7, v_u_5, p680.pickaxe_name, v694)
	local v697 = v_u_7
	local v698 = v681 + 15
	local v699 = p680.timestamp
	buffer.writef64(v697, v698, v699)
end
local function v_u_711(p701)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v702 = v_u_17(5)
	local v703 = v_u_7
	local v704 = v702 + 0
	buffer.writeu8(v703, v704, 33)
	local v705 = #p701.tier
	local v706 = v_u_7
	local v707 = v702 + 1
	buffer.writeu16(v706, v707, v705)
	v_u_17(v705)
	buffer.writestring(v_u_7, v_u_5, p701.tier, v705)
	local v708 = #p701.piece
	local v709 = v_u_7
	local v710 = v702 + 3
	buffer.writeu16(v709, v710, v708)
	v_u_17(v708)
	buffer.writestring(v_u_7, v_u_5, p701.piece, v708)
end
local function v_u_719(p712)
	-- upvalues: (copy) v_u_17, (ref) v_u_7, (ref) v_u_5
	local v713 = v_u_17(3)
	local v714 = v_u_7
	local v715 = v713 + 0
	buffer.writeu8(v714, v715, 34)
	local v716 = #p712
	local v717 = v_u_7
	local v718 = v713 + 1
	buffer.writeu16(v717, v718, v716)
	v_u_17(v716)
	buffer.writestring(v_u_7, v_u_5, p712, v716)
end
if not v2:IsRunning() then
	local function v720() end
	local v721 = table.freeze
	local v722 = {}
	local v723 = {
		["entity_scored"] = {
			["on"] = v720
		},
		["team_won"] = {
			["on"] = v720
		},
		["get_parties"] = {
			["invoke"] = v720
		},
		["spawn_dropped_item"] = {
			["iter"] = v720,
			["next"] = v720
		},
		["delete_dropped_item"] = {
			["iter"] = v720,
			["next"] = v720
		},
		["update_dropped_item"] = {
			["iter"] = v720,
			["next"] = v720
		}
	}
	v722.game_state = v723
	local v724 = {
		["device_type_changed"] = {
			["fire"] = v720
		},
		["device_type_received"] = {
			["on"] = v720
		},
		["get_device_type"] = {
			["invoke"] = v720
		},
		["token_found"] = {
			["on"] = v720
		},
		["cosmetic_received"] = {
			["on"] = v720
		},
		["client_guild_ready"] = {
			["fire"] = v720
		},
		["update_head_rotation"] = {
			["fire"] = v720
		},
		["head_rotation_updated"] = {
			["on"] = v720
		},
		["update_camera_rotation"] = {
			["fire"] = v720
		},
		["camera_rotation_updated"] = {
			["on"] = v720
		},
		["set_spectating"] = {
			["fire"] = v720
		},
		["update_cps"] = {
			["fire"] = v720
		},
		["get_cps"] = {
			["invoke"] = v720
		},
		["take_fall_damage"] = {
			["fire"] = v720
		},
		["system_message"] = {
			["on"] = v720
		},
		["claim_interaction_reward"] = {
			["fire"] = v720
		},
		["teleport_to_lobby"] = {
			["fire"] = v720
		},
		["drop_item"] = {
			["fire"] = v720
		},
		["bedwars_buy_item"] = {
			["invoke"] = v720
		},
		["bedwars_buy_upgrade"] = {
			["invoke"] = v720
		},
		["refund_received"] = {
			["on"] = v720
		},
		["gift_pass"] = {
			["fire"] = v720
		},
		["gift_pass_result"] = {
			["on"] = v720
		},
		["egg_obtained"] = {
			["on"] = v720
		},
		["puzzle_step_completed"] = {
			["on"] = v720
		},
		["egg_fragment_collected"] = {
			["on"] = v720
		}
	}
	v722.player_state = v724
	local v725 = {
		["get_player_leaderboard"] = {
			["invoke"] = v720
		},
		["get_guild_leaderboard"] = {
			["invoke"] = v720
		}
	}
	v722.leaderboards = v725
	local v726 = {
		["attack_entity"] = {
			["fire"] = v720
		},
		["place_block"] = {
			["invoke"] = v720
		},
		["start_break_block"] = {
			["fire"] = v720
		},
		["stop_break_block"] = {
			["fire"] = v720
		},
		["equip_armour"] = {
			["fire"] = v720
		},
		["unequip_armour"] = {
			["fire"] = v720
		}
	}
	v722.item_action = v726
	return v721(v722)
end
if not v2:IsClient() then
	error("Client network module can only be required from the client.")
end
local v_u_727 = v1:WaitForChild("BLINK_RELIABLE_REMOTE")
local v_u_728 = v1:WaitForChild("BLINK_UNRELIABLE_REMOTE")
local function v_u_730()
	-- upvalues: (ref) v_u_6, (ref) v_u_7, (copy) v_u_727, (ref) v_u_8, (ref) v_u_4, (ref) v_u_5
	if v_u_6 > 0 then
		local v729 = buffer.create(v_u_6)
		buffer.copy(v729, 0, v_u_7, 0, v_u_6)
		v_u_727:FireServer(v729, v_u_8)
		v_u_4 = 64
		v_u_6 = 0
		v_u_5 = 0
		v_u_7 = buffer.create(64)
		table.clear(v_u_8)
	end
end
local v_u_731 = 0
v2.Heartbeat:Connect(function(p732)
	-- upvalues: (ref) v_u_731, (copy) v_u_730
	v_u_731 = v_u_731 + p732
	if v_u_731 >= 0.01639344262295082 then
		v_u_731 = v_u_731 - 0.01639344262295082
		v_u_730()
	end
end)
v_u_727.OnClientEvent:Connect(function(p733, p734)
	-- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (copy) v_u_19, (copy) v_u_20, (copy) v_u_22, (copy) v_u_18, (copy) v_u_39, (copy) v_u_59, (copy) v_u_73, (copy) v_u_94, (copy) v_u_105, (copy) v_u_484, (copy) v_u_516, (copy) v_u_546, (copy) v_u_563, (copy) v_u_679
	v_u_9 = 0
	v_u_10 = p733
	v_u_11 = p734
	v_u_12 = 0
	local v735 = buffer.len(v_u_10)
	while v_u_9 < v735 do
		local v736 = v_u_9
		v_u_9 = v_u_9 + 1
		local v737 = v_u_10
		local v738 = v736 + 0
		local v739 = buffer.readu8(v737, v738)
		if v739 == 0 then
			local v740 = v_u_9
			v_u_9 = v_u_9 + 4
			local v741 = v_u_10
			local v742 = v740 + 0
			local v743 = buffer.readu32(v741, v742)
			if #v_u_19.Reliable[0] > 0 then
				for _, v744 in v_u_19.Reliable[0] do
					v744(v743)
				end
			else
				if #v_u_20.Reliable[0] > 256 then
					warn("[Blink]: Event queue of \"entity_scored\" exceeded 256, did you forget to implement a listener?")
				end
				local v745 = v_u_20.Reliable[0]
				table.insert(v745, { v743 })
			end
		elseif v739 == 1 then
			local v746 = v_u_22()
			if #v_u_19.Reliable[1] > 0 then
				for _, v747 in v_u_19.Reliable[1] do
					v747(v746)
				end
			else
				if #v_u_20.Reliable[1] > 256 then
					warn("[Blink]: Event queue of \"team_won\" exceeded 256, did you forget to implement a listener?")
				end
				local v748 = v_u_20.Reliable[1]
				table.insert(v748, { v746 })
			end
		elseif v739 == 2 then
			local v749 = v_u_9
			v_u_9 = v_u_9 + 1
			local v750 = v_u_10
			local v751 = v749 + 0
			local v752 = buffer.readu8(v750, v751)
			if v_u_18[v752] ~= nil then
				local v753, v754 = pcall(function()
					-- upvalues: (ref) v_u_39
					return v_u_39()
				end)
				task.spawn(v_u_18[v752], v753, v754)
				v_u_18[v752] = nil
			end
		elseif v739 == 3 then
			local v755 = v_u_20.Reliable[3]
			local v756 = {
				["value"] = table.pack((v_u_59())),
				["next"] = nil
			}
			if v755.tail ~= nil then
				v755.tail.next = v756
			end
			v755.tail = v756
			if v755.head == nil then
				v755.head = v756
			end
		elseif v739 == 4 then
			local v757 = v_u_20.Reliable[4]
			local v758 = table.pack
			local v759 = v_u_9
			v_u_9 = v_u_9 + 8
			local v760 = v_u_10
			local v761 = v759 + 0
			local v762 = {
				["value"] = v758((buffer.readf64(v760, v761))),
				["next"] = nil
			}
			if v757.tail ~= nil then
				v757.tail.next = v762
			end
			v757.tail = v762
			if v757.head == nil then
				v757.head = v762
			end
		elseif v739 == 5 then
			local v763 = v_u_20.Reliable[5]
			local v764 = {
				["value"] = table.pack((v_u_73())),
				["next"] = nil
			}
			if v763.tail ~= nil then
				v763.tail.next = v764
			end
			v763.tail = v764
			if v763.head == nil then
				v763.head = v764
			end
		elseif v739 == 7 then
			local v765 = v_u_94()
			if v_u_19.Reliable[7] == nil then
				if #v_u_20.Reliable[7] > 256 then
					warn("[Blink]: Event queue of \"device_type_received\" exceeded 256, did you forget to implement a listener?")
				end
				local v766 = v_u_20.Reliable[7]
				table.insert(v766, { v765 })
			else
				v_u_19.Reliable[7](v765)
			end
		elseif v739 == 8 then
			local v767 = v_u_9
			v_u_9 = v_u_9 + 1
			local v768 = v_u_10
			local v769 = v767 + 0
			local v770 = buffer.readu8(v768, v769)
			if v_u_18[v770] ~= nil then
				local v771, v772 = pcall(function()
					-- upvalues: (ref) v_u_105
					return v_u_105()
				end)
				task.spawn(v_u_18[v770], v771, v772)
				v_u_18[v770] = nil
			end
		elseif v739 == 9 then
			local v773 = v_u_9
			v_u_9 = v_u_9 + 2
			local v774 = v_u_10
			local v775 = v773 + 0
			local v776 = buffer.readu16(v774, v775)
			local v777 = buffer.readstring
			local v778 = v_u_10
			local v779 = v_u_9
			v_u_9 = v_u_9 + v776
			local v780 = v777(v778, v779, v776)
			if v_u_19.Reliable[9] == nil then
				if #v_u_20.Reliable[9] > 256 then
					warn("[Blink]: Event queue of \"token_found\" exceeded 256, did you forget to implement a listener?")
				end
				local v781 = v_u_20.Reliable[9]
				table.insert(v781, { v780 })
			else
				v_u_19.Reliable[9](v780)
			end
		elseif v739 == 10 then
			local v782 = v_u_9
			v_u_9 = v_u_9 + 2
			local v783 = v_u_10
			local v784 = v782 + 0
			local v785 = buffer.readu16(v783, v784)
			local v786 = buffer.readstring
			local v787 = v_u_10
			local v788 = v_u_9
			v_u_9 = v_u_9 + v785
			local v789 = v786(v787, v788, v785)
			if #v_u_19.Reliable[10] > 0 then
				for _, v790 in v_u_19.Reliable[10] do
					v790(v789)
				end
			else
				if #v_u_20.Reliable[10] > 256 then
					warn("[Blink]: Event queue of \"cosmetic_received\" exceeded 256, did you forget to implement a listener?")
				end
				local v791 = v_u_20.Reliable[10]
				table.insert(v791, { v789 })
			end
		elseif v739 == 13 then
			local v792 = v_u_9
			v_u_9 = v_u_9 + 1
			local v793 = v_u_10
			local v794 = v792 + 0
			local v795 = buffer.readu8(v793, v794)
			if v_u_18[v795] ~= nil then
				local v805, v806 = pcall(function()
					-- upvalues: (ref) v_u_9, (ref) v_u_10
					local v796 = v_u_9
					v_u_9 = v_u_9 + 2
					local v797 = v_u_10
					local v798 = v796 + 0
					if buffer.readu8(v797, v798) ~= 1 then
						error("Server encountered an error.")
					end
					local v799 = v_u_10
					local v800 = v796 + 1
					local v801
					if buffer.readu8(v799, v800) == 1 then
						local v802 = v_u_9
						v_u_9 = v_u_9 + 1
						local v803 = v_u_10
						local v804 = v802 + 0
						v801 = buffer.readu8(v803, v804)
					else
						v801 = nil
					end
					return v801
				end)
				task.spawn(v_u_18[v795], v805, v806)
				v_u_18[v795] = nil
			end
		elseif v739 == 15 then
			local v807 = v_u_9
			v_u_9 = v_u_9 + 2
			local v808 = v_u_10
			local v809 = v807 + 0
			local v810 = buffer.readu16(v808, v809)
			local v811 = buffer.readstring
			local v812 = v_u_10
			local v813 = v_u_9
			v_u_9 = v_u_9 + v810
			local v814 = v811(v812, v813, v810)
			if v_u_19.Reliable[15] == nil then
				if #v_u_20.Reliable[15] > 256 then
					warn("[Blink]: Event queue of \"system_message\" exceeded 256, did you forget to implement a listener?")
				end
				local v815 = v_u_20.Reliable[15]
				table.insert(v815, { v814 })
			else
				v_u_19.Reliable[15](v814)
			end
		elseif v739 == 19 then
			local v816 = v_u_9
			v_u_9 = v_u_9 + 1
			local v817 = v_u_10
			local v818 = v816 + 0
			local v819 = buffer.readu8(v817, v818)
			if v_u_18[v819] ~= nil then
				local v825, v826 = pcall(function()
					-- upvalues: (ref) v_u_9, (ref) v_u_10
					local v820 = v_u_9
					v_u_9 = v_u_9 + 2
					local v821 = v_u_10
					local v822 = v820 + 0
					if buffer.readu8(v821, v822) ~= 1 then
						error("Server encountered an error.")
					end
					local v823 = v_u_10
					local v824 = v820 + 1
					return buffer.readu8(v823, v824) == 1
				end)
				task.spawn(v_u_18[v819], v825, v826)
				v_u_18[v819] = nil
			end
		elseif v739 == 20 then
			local v827 = v_u_9
			v_u_9 = v_u_9 + 1
			local v828 = v_u_10
			local v829 = v827 + 0
			local v830 = buffer.readu8(v828, v829)
			if v_u_18[v830] ~= nil then
				local v836, v837 = pcall(function()
					-- upvalues: (ref) v_u_9, (ref) v_u_10
					local v831 = v_u_9
					v_u_9 = v_u_9 + 2
					local v832 = v_u_10
					local v833 = v831 + 0
					if buffer.readu8(v832, v833) ~= 1 then
						error("Server encountered an error.")
					end
					local v834 = v_u_10
					local v835 = v831 + 1
					return buffer.readu8(v834, v835) == 1
				end)
				task.spawn(v_u_18[v830], v836, v837)
				v_u_18[v830] = nil
			end
		elseif v739 == 21 then
			local v838 = v_u_484()
			if v_u_19.Reliable[21] == nil then
				if #v_u_20.Reliable[21] > 256 then
					warn("[Blink]: Event queue of \"refund_received\" exceeded 256, did you forget to implement a listener?")
				end
				local v839 = v_u_20.Reliable[21]
				table.insert(v839, { v838 })
			else
				v_u_19.Reliable[21](v838)
			end
		elseif v739 == 23 then
			local v840 = v_u_516()
			if v_u_19.Reliable[23] == nil then
				if #v_u_20.Reliable[23] > 256 then
					warn("[Blink]: Event queue of \"gift_pass_result\" exceeded 256, did you forget to implement a listener?")
				end
				local v841 = v_u_20.Reliable[23]
				table.insert(v841, { v840 })
			else
				v_u_19.Reliable[23](v840)
			end
		elseif v739 == 24 then
			local v842 = v_u_9
			v_u_9 = v_u_9 + 2
			local v843 = v_u_10
			local v844 = v842 + 0
			local v845 = buffer.readu16(v843, v844)
			local v846 = buffer.readstring
			local v847 = v_u_10
			local v848 = v_u_9
			v_u_9 = v_u_9 + v845
			local v849 = v846(v847, v848, v845)
			if #v_u_19.Reliable[24] > 0 then
				for _, v850 in v_u_19.Reliable[24] do
					v850(v849)
				end
			else
				if #v_u_20.Reliable[24] > 256 then
					warn("[Blink]: Event queue of \"egg_obtained\" exceeded 256, did you forget to implement a listener?")
				end
				local v851 = v_u_20.Reliable[24]
				table.insert(v851, { v849 })
			end
		elseif v739 == 25 then
			local v852 = v_u_9
			v_u_9 = v_u_9 + 1
			local v853 = v_u_10
			local v854 = v852 + 0
			local v855 = buffer.readu8(v853, v854)
			if v_u_19.Reliable[25] == nil then
				if #v_u_20.Reliable[25] > 256 then
					warn("[Blink]: Event queue of \"puzzle_step_completed\" exceeded 256, did you forget to implement a listener?")
				end
				local v856 = v_u_20.Reliable[25]
				table.insert(v856, { v855 })
			else
				v_u_19.Reliable[25](v855)
			end
		elseif v739 == 26 then
			local v857 = v_u_9
			v_u_9 = v_u_9 + 1
			local v858 = v_u_10
			local v859 = v857 + 0
			local v860 = buffer.readu8(v858, v859)
			if #v_u_19.Reliable[26] > 0 then
				for _, v861 in v_u_19.Reliable[26] do
					v861(v860)
				end
			else
				if #v_u_20.Reliable[26] > 256 then
					warn("[Blink]: Event queue of \"egg_fragment_collected\" exceeded 256, did you forget to implement a listener?")
				end
				local v862 = v_u_20.Reliable[26]
				table.insert(v862, { v860 })
			end
		elseif v739 == 27 then
			local v863 = v_u_9
			v_u_9 = v_u_9 + 1
			local v864 = v_u_10
			local v865 = v863 + 0
			local v866 = buffer.readu8(v864, v865)
			if v_u_18[v866] ~= nil then
				local v867, v868 = pcall(function()
					-- upvalues: (ref) v_u_546
					return v_u_546()
				end)
				task.spawn(v_u_18[v866], v867, v868)
				v_u_18[v866] = nil
			end
		elseif v739 == 28 then
			local v869 = v_u_9
			v_u_9 = v_u_9 + 1
			local v870 = v_u_10
			local v871 = v869 + 0
			local v872 = buffer.readu8(v870, v871)
			if v_u_18[v872] ~= nil then
				local v873, v874 = pcall(function()
					-- upvalues: (ref) v_u_563
					return v_u_563()
				end)
				task.spawn(v_u_18[v872], v873, v874)
				v_u_18[v872] = nil
			end
		elseif v739 == 30 then
			local v875 = v_u_9
			v_u_9 = v_u_9 + 1
			local v876 = v_u_10
			local v877 = v875 + 0
			local v878 = buffer.readu8(v876, v877)
			if v_u_18[v878] ~= nil then
				local v879, v880, v881 = pcall(function()
					-- upvalues: (ref) v_u_679
					return v_u_679()
				end)
				task.spawn(v_u_18[v878], v879, v880, v881)
				v_u_18[v878] = nil
			end
		end
	end
end)
v_u_728.OnClientEvent:Connect(function(p882, p883)
	-- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_11, (ref) v_u_12, (copy) v_u_213, (copy) v_u_19, (copy) v_u_425
	v_u_9 = 0
	v_u_10 = p882
	v_u_11 = p883
	v_u_12 = 0
	local v884 = buffer.len(v_u_10)
	while v_u_9 < v884 do
		local v885 = v_u_9
		v_u_9 = v_u_9 + 1
		local v886 = v_u_10
		local v887 = v885 + 0
		local v888 = buffer.readu8(v886, v887)
		if v888 == 1 then
			local v889 = v_u_213()
			if v_u_19.Unreliable[1] ~= nil then
				v_u_19.Unreliable[1](v889)
			end
		elseif v888 == 3 then
			local v890 = v_u_425()
			if v_u_19.Unreliable[3] ~= nil then
				v_u_19.Unreliable[3](v890)
			end
		end
	end
end)
local v891 = table.freeze
local v892 = {
	["step_replication"] = v_u_730
}
local v949 = {
	["entity_scored"] = {
		["on"] = function(p_u_893)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			local v894 = v_u_19.Reliable[0]
			table.insert(v894, p_u_893)
			for _, v895 in v_u_20.Reliable[0] do
				p_u_893(table.unpack(v895))
			end
			v_u_20.Reliable[0] = {}
			return function()
				-- upvalues: (ref) v_u_19, (copy) p_u_893
				table.remove(v_u_19.Reliable[0], table.find(v_u_19.Reliable[0], p_u_893))
			end
		end
	},
	["team_won"] = {
		["on"] = function(p_u_896)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			local v897 = v_u_19.Reliable[1]
			table.insert(v897, p_u_896)
			for _, v898 in v_u_20.Reliable[1] do
				p_u_896(table.unpack(v898))
			end
			v_u_20.Reliable[1] = {}
			return function()
				-- upvalues: (ref) v_u_19, (copy) p_u_896
				table.remove(v_u_19.Reliable[1], table.find(v_u_19.Reliable[1], p_u_896))
			end
		end
	},
	["get_parties"] = {
		["invoke"] = function(_)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_17, (ref) v_u_7
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v899 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v899] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			local v900 = v_u_17(2)
			local v901 = v_u_7
			local v902 = v900 + 0
			buffer.writeu8(v901, v902, 2)
			local v903 = v_u_7
			local v904 = v900 + 1
			buffer.writeu8(v903, v904, v899)
			v_u_18[v899] = coroutine.running()
			local v905, v906 = coroutine.yield()
			if v905 ~= true then
				error("There was an exception while processing \"get_parties\".")
			end
			return v906
		end
	},
	["spawn_dropped_item"] = {
		["iter"] = function()
			-- upvalues: (copy) v_u_20
			local v_u_907 = 0
			local v_u_908 = v_u_20.Reliable[3]
			return function()
				-- upvalues: (ref) v_u_907, (copy) v_u_908
				v_u_907 = v_u_907 + 1
				local v909 = v_u_908
				local v910 = v909.head
				local v911
				if v910 == nil then
					v911 = nil
				else
					v909.head = v910.next
					v911 = v910.value
				end
				if v911 ~= nil then
					local v912 = v_u_907
					local v913 = v911.n
					return v912, unpack(v911, 1, v913)
				end
			end
		end,
		["next"] = function()
			-- upvalues: (copy) v_u_20
			local v_u_914 = 0
			local v_u_915 = v_u_20.Reliable[3]
			return function()
				-- upvalues: (ref) v_u_914, (copy) v_u_915
				v_u_914 = v_u_914 + 1
				local v916 = v_u_915
				local v917 = v916.head
				local v918
				if v917 == nil then
					v918 = nil
				else
					v916.head = v917.next
					v918 = v917.value
				end
				if v918 ~= nil then
					local v919 = v_u_914
					local v920 = v918.n
					return v919, unpack(v918, 1, v920)
				end
			end
		end
	},
	["delete_dropped_item"] = {
		["iter"] = function()
			-- upvalues: (copy) v_u_20
			local v_u_921 = 0
			local v_u_922 = v_u_20.Reliable[4]
			return function()
				-- upvalues: (ref) v_u_921, (copy) v_u_922
				v_u_921 = v_u_921 + 1
				local v923 = v_u_922
				local v924 = v923.head
				local v925
				if v924 == nil then
					v925 = nil
				else
					v923.head = v924.next
					v925 = v924.value
				end
				if v925 ~= nil then
					local v926 = v_u_921
					local v927 = v925.n
					return v926, unpack(v925, 1, v927)
				end
			end
		end,
		["next"] = function()
			-- upvalues: (copy) v_u_20
			local v_u_928 = 0
			local v_u_929 = v_u_20.Reliable[4]
			return function()
				-- upvalues: (ref) v_u_928, (copy) v_u_929
				v_u_928 = v_u_928 + 1
				local v930 = v_u_929
				local v931 = v930.head
				local v932
				if v931 == nil then
					v932 = nil
				else
					v930.head = v931.next
					v932 = v931.value
				end
				if v932 ~= nil then
					local v933 = v_u_928
					local v934 = v932.n
					return v933, unpack(v932, 1, v934)
				end
			end
		end
	},
	["update_dropped_item"] = {
		["iter"] = function()
			-- upvalues: (copy) v_u_20
			local v_u_935 = 0
			local v_u_936 = v_u_20.Reliable[5]
			return function()
				-- upvalues: (ref) v_u_935, (copy) v_u_936
				v_u_935 = v_u_935 + 1
				local v937 = v_u_936
				local v938 = v937.head
				local v939
				if v938 == nil then
					v939 = nil
				else
					v937.head = v938.next
					v939 = v938.value
				end
				if v939 ~= nil then
					local v940 = v_u_935
					local v941 = v939.n
					return v940, unpack(v939, 1, v941)
				end
			end
		end,
		["next"] = function()
			-- upvalues: (copy) v_u_20
			local v_u_942 = 0
			local v_u_943 = v_u_20.Reliable[5]
			return function()
				-- upvalues: (ref) v_u_942, (copy) v_u_943
				v_u_942 = v_u_942 + 1
				local v944 = v_u_943
				local v945 = v944.head
				local v946
				if v945 == nil then
					v946 = nil
				else
					v944.head = v945.next
					v946 = v945.value
				end
				if v946 ~= nil then
					local v947 = v_u_942
					local v948 = v946.n
					return v947, unpack(v946, 1, v948)
				end
			end
		end
	}
}
v892.game_state = v949
local v1042 = {
	["device_type_changed"] = {
		["fire"] = function(p950)
			-- upvalues: (copy) v_u_84
			v_u_84(p950)
		end
	},
	["device_type_received"] = {
		["on"] = function(p951)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			v_u_19.Reliable[7] = p951
			for _, v952 in v_u_20.Reliable[7] do
				p951(table.unpack(v952))
			end
			v_u_20.Reliable[7] = {}
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Reliable[7] = nil
			end
		end
	},
	["get_device_type"] = {
		["invoke"] = function(p953)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_17, (ref) v_u_7, (ref) v_u_8, (copy) v_u_13
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v954 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v954] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			local v955 = v_u_17(2)
			local v956 = v_u_7
			local v957 = v955 + 0
			buffer.writeu8(v956, v957, 8)
			local v958 = v_u_7
			local v959 = v955 + 1
			buffer.writeu8(v958, v959, v954)
			local v960 = v_u_8
			local v961 = p953 or v_u_13
			table.insert(v960, v961)
			v_u_18[v954] = coroutine.running()
			local v962, v963 = coroutine.yield()
			if v962 ~= true then
				error("There was an exception while processing \"get_device_type\".")
			end
			return v963
		end
	},
	["token_found"] = {
		["on"] = function(p964)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			v_u_19.Reliable[9] = p964
			for _, v965 in v_u_20.Reliable[9] do
				p964(table.unpack(v965))
			end
			v_u_20.Reliable[9] = {}
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Reliable[9] = nil
			end
		end
	},
	["cosmetic_received"] = {
		["on"] = function(p_u_966)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			local v967 = v_u_19.Reliable[10]
			table.insert(v967, p_u_966)
			for _, v968 in v_u_20.Reliable[10] do
				p_u_966(table.unpack(v968))
			end
			v_u_20.Reliable[10] = {}
			return function()
				-- upvalues: (ref) v_u_19, (copy) p_u_966
				table.remove(v_u_19.Reliable[10], table.find(v_u_19.Reliable[10], p_u_966))
			end
		end
	},
	["client_guild_ready"] = {
		["fire"] = function(_)
			-- upvalues: (copy) v_u_17, (ref) v_u_7
			local v969 = v_u_7
			local v970 = v_u_17(1) + 0
			buffer.writeu8(v969, v970, 11)
		end
	},
	["update_head_rotation"] = {
		["fire"] = function(p971)
			-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_5, (copy) v_u_179, (copy) v_u_728
			local v972 = {
				["Size"] = v_u_4,
				["Cursor"] = v_u_6,
				["Buffer"] = v_u_7,
				["Instances"] = v_u_8
			}
			v_u_4 = 64
			v_u_6 = 0
			v_u_5 = 0
			v_u_7 = buffer.create(64)
			v_u_8 = {}
			v_u_179(p971)
			local v973 = buffer.create(v_u_6)
			buffer.copy(v973, 0, v_u_7, 0, v_u_6)
			v_u_728:FireServer(v973, v_u_8)
			if v972 then
				v_u_4 = v972.Size
				v_u_6 = v972.Cursor
				v_u_5 = v972.Cursor
				v_u_7 = v972.Buffer
				v_u_8 = v972.Instances
			else
				v_u_4 = 64
				v_u_6 = 0
				v_u_5 = 0
				v_u_7 = buffer.create(64)
				v_u_8 = {}
			end
		end
	},
	["head_rotation_updated"] = {
		["on"] = function(p974)
			-- upvalues: (copy) v_u_19
			v_u_19.Unreliable[1] = p974
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Unreliable[1] = nil
			end
		end
	},
	["update_camera_rotation"] = {
		["fire"] = function(p975, p976)
			-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_5, (copy) v_u_363, (copy) v_u_728
			local v977 = {
				["Size"] = v_u_4,
				["Cursor"] = v_u_6,
				["Buffer"] = v_u_7,
				["Instances"] = v_u_8
			}
			v_u_4 = 64
			v_u_6 = 0
			v_u_5 = 0
			v_u_7 = buffer.create(64)
			v_u_8 = {}
			v_u_363(p975, p976)
			local v978 = buffer.create(v_u_6)
			buffer.copy(v978, 0, v_u_7, 0, v_u_6)
			v_u_728:FireServer(v978, v_u_8)
			if v977 then
				v_u_4 = v977.Size
				v_u_6 = v977.Cursor
				v_u_5 = v977.Cursor
				v_u_7 = v977.Buffer
				v_u_8 = v977.Instances
			else
				v_u_4 = 64
				v_u_6 = 0
				v_u_5 = 0
				v_u_7 = buffer.create(64)
				v_u_8 = {}
			end
		end
	},
	["camera_rotation_updated"] = {
		["on"] = function(p979)
			-- upvalues: (copy) v_u_19
			v_u_19.Unreliable[3] = p979
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Unreliable[3] = nil
			end
		end
	},
	["set_spectating"] = {
		["fire"] = function(p980)
			-- upvalues: (copy) v_u_17, (ref) v_u_7
			local v981 = v_u_17(2)
			local v982 = v_u_7
			local v983 = v981 + 0
			buffer.writeu8(v982, v983, 12)
			local v984 = v_u_7
			local v985 = v981 + 1
			local v986 = p980 == nil and 0 or 1
			buffer.writeu8(v984, v985, v986)
			if p980 ~= nil then
				local v987 = v_u_7
				local v988 = v_u_17(2) + 0
				buffer.writeu16(v987, v988, p980)
			end
		end
	},
	["update_cps"] = {
		["fire"] = function(p989)
			-- upvalues: (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (ref) v_u_5, (copy) v_u_17, (copy) v_u_728
			local v990 = {
				["Size"] = v_u_4,
				["Cursor"] = v_u_6,
				["Buffer"] = v_u_7,
				["Instances"] = v_u_8
			}
			v_u_4 = 64
			v_u_6 = 0
			v_u_5 = 0
			v_u_7 = buffer.create(64)
			v_u_8 = {}
			local v991 = v_u_17(2)
			local v992 = v_u_7
			local v993 = v991 + 0
			buffer.writeu8(v992, v993, 4)
			local v994 = v_u_7
			local v995 = v991 + 1
			buffer.writeu8(v994, v995, p989)
			local v996 = buffer.create(v_u_6)
			buffer.copy(v996, 0, v_u_7, 0, v_u_6)
			v_u_728:FireServer(v996, v_u_8)
			if v990 then
				v_u_4 = v990.Size
				v_u_6 = v990.Cursor
				v_u_5 = v990.Cursor
				v_u_7 = v990.Buffer
				v_u_8 = v990.Instances
			else
				v_u_4 = 64
				v_u_6 = 0
				v_u_5 = 0
				v_u_7 = buffer.create(64)
				v_u_8 = {}
			end
		end
	},
	["get_cps"] = {
		["invoke"] = function(p997)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_17, (ref) v_u_7, (ref) v_u_8, (copy) v_u_13
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v998 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v998] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			local v999 = v_u_17(2)
			local v1000 = v_u_7
			local v1001 = v999 + 0
			buffer.writeu8(v1000, v1001, 13)
			local v1002 = v_u_7
			local v1003 = v999 + 1
			buffer.writeu8(v1002, v1003, v998)
			local v1004 = v_u_8
			local v1005 = p997 or v_u_13
			table.insert(v1004, v1005)
			v_u_18[v998] = coroutine.running()
			local v1006, v1007 = coroutine.yield()
			if v1006 ~= true then
				error("There was an exception while processing \"get_cps\".")
			end
			return v1007
		end
	},
	["take_fall_damage"] = {
		["fire"] = function(p1008)
			-- upvalues: (copy) v_u_17, (ref) v_u_7
			local v1009 = v_u_17(2)
			local v1010 = v_u_7
			local v1011 = v1009 + 0
			buffer.writeu8(v1010, v1011, 14)
			local v1012 = v_u_7
			local v1013 = v1009 + 1
			buffer.writeu8(v1012, v1013, p1008)
		end
	},
	["system_message"] = {
		["on"] = function(p1014)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			v_u_19.Reliable[15] = p1014
			for _, v1015 in v_u_20.Reliable[15] do
				p1014(table.unpack(v1015))
			end
			v_u_20.Reliable[15] = {}
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Reliable[15] = nil
			end
		end
	},
	["claim_interaction_reward"] = {
		["fire"] = function(_)
			-- upvalues: (copy) v_u_17, (ref) v_u_7
			local v1016 = v_u_7
			local v1017 = v_u_17(1) + 0
			buffer.writeu8(v1016, v1017, 16)
		end
	},
	["teleport_to_lobby"] = {
		["fire"] = function(_)
			-- upvalues: (copy) v_u_17, (ref) v_u_7
			local v1018 = v_u_7
			local v1019 = v_u_17(1) + 0
			buffer.writeu8(v1018, v1019, 17)
		end
	},
	["drop_item"] = {
		["fire"] = function(p1020)
			-- upvalues: (copy) v_u_433
			v_u_433(p1020)
		end
	},
	["bedwars_buy_item"] = {
		["invoke"] = function(p1021)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_450
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v1022 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v1022] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			v_u_450(p1021, v1022)
			v_u_18[v1022] = coroutine.running()
			local v1023, v1024 = coroutine.yield()
			if v1023 ~= true then
				error("There was an exception while processing \"bedwars_buy_item\".")
			end
			return v1024
		end
	},
	["bedwars_buy_upgrade"] = {
		["invoke"] = function(p1025)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_461
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v1026 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v1026] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			v_u_461(p1025, v1026)
			v_u_18[v1026] = coroutine.running()
			local v1027, v1028 = coroutine.yield()
			if v1027 ~= true then
				error("There was an exception while processing \"bedwars_buy_upgrade\".")
			end
			return v1028
		end
	},
	["refund_received"] = {
		["on"] = function(p1029)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			v_u_19.Reliable[21] = p1029
			for _, v1030 in v_u_20.Reliable[21] do
				p1029(table.unpack(v1030))
			end
			v_u_20.Reliable[21] = {}
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Reliable[21] = nil
			end
		end
	},
	["gift_pass"] = {
		["fire"] = function(p1031)
			-- upvalues: (copy) v_u_495
			v_u_495(p1031)
		end
	},
	["gift_pass_result"] = {
		["on"] = function(p1032)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			v_u_19.Reliable[23] = p1032
			for _, v1033 in v_u_20.Reliable[23] do
				p1032(table.unpack(v1033))
			end
			v_u_20.Reliable[23] = {}
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Reliable[23] = nil
			end
		end
	},
	["egg_obtained"] = {
		["on"] = function(p_u_1034)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			local v1035 = v_u_19.Reliable[24]
			table.insert(v1035, p_u_1034)
			for _, v1036 in v_u_20.Reliable[24] do
				p_u_1034(table.unpack(v1036))
			end
			v_u_20.Reliable[24] = {}
			return function()
				-- upvalues: (ref) v_u_19, (copy) p_u_1034
				table.remove(v_u_19.Reliable[24], table.find(v_u_19.Reliable[24], p_u_1034))
			end
		end
	},
	["puzzle_step_completed"] = {
		["on"] = function(p1037)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			v_u_19.Reliable[25] = p1037
			for _, v1038 in v_u_20.Reliable[25] do
				p1037(table.unpack(v1038))
			end
			v_u_20.Reliable[25] = {}
			return function()
				-- upvalues: (ref) v_u_19
				v_u_19.Reliable[25] = nil
			end
		end
	},
	["egg_fragment_collected"] = {
		["on"] = function(p_u_1039)
			-- upvalues: (copy) v_u_19, (copy) v_u_20
			local v1040 = v_u_19.Reliable[26]
			table.insert(v1040, p_u_1039)
			for _, v1041 in v_u_20.Reliable[26] do
				p_u_1039(table.unpack(v1041))
			end
			v_u_20.Reliable[26] = {}
			return function()
				-- upvalues: (ref) v_u_19, (copy) p_u_1039
				table.remove(v_u_19.Reliable[26], table.find(v_u_19.Reliable[26], p_u_1039))
			end
		end
	}
}
v892.player_state = v1042
local v1055 = {
	["get_player_leaderboard"] = {
		["invoke"] = function(p1043)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_527
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v1044 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v1044] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			v_u_527(p1043, v1044)
			v_u_18[v1044] = coroutine.running()
			local v1045, v1046 = coroutine.yield()
			if v1045 ~= true then
				error("There was an exception while processing \"get_player_leaderboard\".")
			end
			return v1046
		end
	},
	["get_guild_leaderboard"] = {
		["invoke"] = function(_)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_17, (ref) v_u_7
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v1047 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v1047] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			local v1048 = v_u_17(2)
			local v1049 = v_u_7
			local v1050 = v1048 + 0
			buffer.writeu8(v1049, v1050, 28)
			local v1051 = v_u_7
			local v1052 = v1048 + 1
			buffer.writeu8(v1051, v1052, v1047)
			v_u_18[v1047] = coroutine.running()
			local v1053, v1054 = coroutine.yield()
			if v1053 ~= true then
				error("There was an exception while processing \"get_guild_leaderboard\".")
			end
			return v1054
		end
	}
}

v892.leaderboards = v1055
local v1071 = {
	["attack_entity"] = {
		["fire"] = function(p1056)
			-- upvalues: (copy) v_u_611
			v_u_611(p1056)
		end
	},
	["place_block"] = {
		["invoke"] = function(p1057)
			-- upvalues: (ref) v_u_3, (copy) v_u_18, (copy) v_u_666
			if v_u_3 == 255 then
				v_u_3 = 0
			end
			local v1058 = v_u_3
			v_u_3 = v_u_3 + 1
			if v_u_18[v1058] ~= nil then
				v_u_3 = v_u_3 - 1
				error("More than 256 calls are awaiting a response, this packet has been dropped.")
			end
			v_u_666(p1057, v1058)
			v_u_18[v1058] = coroutine.running()
			local v1059, v1060, v1061 = coroutine.yield()
			if v1059 ~= true then
				error("There was an exception while processing \"place_block\".")
			end
			return v1060, v1061
		end
	},
	["start_break_block"] = {
		["fire"] = function(p1062)
			-- upvalues: (copy) v_u_700
			v_u_700(p1062)
		end
	},
	["stop_break_block"] = {
		["fire"] = function(p1063)
			-- upvalues: (copy) v_u_17, (ref) v_u_7
			local v1064 = v_u_17(2)
			local v1065 = v_u_7
			local v1066 = v1064 + 0
			buffer.writeu8(v1065, v1066, 32)
			local v1067 = v_u_7
			local v1068 = v1064 + 1
			buffer.writeu8(v1067, v1068, p1063 and 1 or 0)
		end
	},
	["equip_armour"] = {
		["fire"] = function(p1069)
			-- upvalues: (copy) v_u_711
			v_u_711(p1069)
		end
	},
	["unequip_armour"] = {
		["fire"] = function(p1070)
			-- upvalues: (copy) v_u_719
			v_u_719(p1070)
		end
	}
}

v892.item_action = v1071
return v891(v892)