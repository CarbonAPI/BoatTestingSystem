 --this is VERY VERY VERY centric and prob won't work on your game if you try to use it.
 --This is being uploaded to be stored by carbonapi. Thank you for reading this documentation!
 
 local nthread = coroutine.create(function()
	local rt = game:GetService("RunService")
	d = game:GetService("Debris")
	plr = game.Players.LocalPlayer
	game.Workspace:WaitForChild(plr.Name)
	char = plr.Character
	char.Torso.Anchored = true
	char:MoveTo(Vector3.new(0, 2000, 0))
	char.Humanoid.Name = "NotHumanoid"
	c = game.Workspace.Camera
	local hurtDebounce = false
	local speedVal = 0
	local turnDeg = .5
	local wheelTurnDeg = 2
	game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
		Text = "Welcome to my game! Please wait for the terrain to load.";
		Color = Color3.new(237/255, 233/255, 180/255);
		Font = Enum.Font.SourceSansBold;
		FontSize = Enum.FontSize.Size18;
	})	
	
			
	for _,v in pairs(char:GetChildren()) do
		if v:IsA("Part") then
			v.Transparency = 1
		end
	end
	wait(1)
	for _,v in pairs(char:GetChildren()) do
		if v:IsA("Hat") then
			v:Destroy()
		end
	end
	
	

	function start()
		char.Torso.Anchored = true
		local ok = game.ReplicatedStorage.StarterShip:Clone()
		ok.Parent = game.Workspace
		ok.Name = plr.Name .. "Ship"
		
		for _, v in pairs(game.Workspace:GetChildren()) do
			if v:IsA("Model") and v.Name == (plr.Name .. "Ship") then
				car = v
			end
		end
		shootDebounce = false
				
				
				
		
		game.Workspace:WaitForChild(plr.Name):WaitForChild("Body Colors")
		wait(1)
		
		--puts char on back of the boat
		local bChar = car.backChar
			
		if bChar:FindFirstChild("Shirt") ~= nil and char:FindFirstChild("Shirt") ~= nil then
			bChar.Shirt.ShirtTemplate = char.Shirt.ShirtTemplate
		end
		if bChar:FindFirstChild("Shirt Graphic") ~= nil and char:FindFirstChild("Shirt Graphic") ~= nil then
			bChar["Shirt Graphic"].Graphic = char["Shirt Graphic"].Graphic
		end
		if bChar:FindFirstChild("Pants") ~= nil and char:FindFirstChild("Pants") ~= nil then
			bChar.Pants.PantsTemplate = char.Pants.PantsTemplate
		end
		if bChar.Head:FindFirstChild("face") ~= nil and char.Head:FindFirstChild("face") ~= nil then
			bChar.Head.face.Texture = char.Head.face.Texture
		end
		if bChar:FindFirstChild("Head") ~= nil and char:FindFirstChild("Head") ~= nil then
			bChar.Head.Mesh.MeshId = char.Head.Mesh.MeshId
		end
		if bChar:FindFirstChild("Body Colors") ~= nil and char:FindFirstChild("Body Colors") ~= nil then
			bChar["Body Colors"].HeadColor = char["Body Colors"].HeadColor
			bChar["Body Colors"].LeftArmColor = char["Body Colors"].LeftArmColor
			bChar["Body Colors"].LeftLegColor = char["Body Colors"].LeftLegColor			
			bChar["Body Colors"].RightArmColor = char["Body Colors"].RightArmColor
			bChar["Body Colors"].RightLegColor = char["Body Colors"].RightLegColor
			bChar["Body Colors"].TorsoColor = char["Body Colors"].TorsoColor
		end
		bChar.Name = " "

		--input service and tags, body gyro, health bar
		local gyro = Instance.new("BodyGyro", car.FirstBeveledBrick)
		car.MainSail.BillboardGui.slider.Size = UDim2.new(1, 0, 1, 0)
		input = game:GetService("UserInputService")
		wTag = Instance.new("BoolValue", car)
		wTag.Name = "wTag"
		sTag = Instance.new("BoolValue", car)
		sTag.Name = "sTag"
		aTag = Instance.new("BoolValue", car)
		aTag.Name = "aTag"
		dTag = Instance.new("BoolValue", car)
		dTag.Name = "dTag"
		local nameTag = Instance.new("StringValue", car)
		nameTag.Name = "nameTag"
		nameTag.Value = plr.Name
	end

		start()
		
		
	
	function deathSeq(p)
		local deathTag = Instance.new("Model", car)
		deathTag.Name = "DYING"	
		--who killed you
		for _,v in pairs(p.Parent:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Value") ~= nil then
				print("Killed by: "..v.Name)
			end
		end
		--camera
		--local rightVector = car.PrimaryPart.CFrame:vectorToWorldSpace(Vector3.new(1, 0, 0))
		--c:Interpolate(CFrame.new((rightVector) + Vector3.new(0, 20, 0)), car.FirstBeveledBrick.CFrame, 2.5)
		
		--starts fire
		local fire = Instance.new("Fire", p.Parent.FirstBeveledBrick)
		fire.Size = 25
		wait(1)
		--fade to black
		for i = 1, 50, 1 do
			for _, v in pairs(p.Parent:GetChildren()) do
				if v:IsA("Part") or v:IsA("UnionOperation") then
					local color = v.BrickColor.Color
					v.BrickColor = BrickColor.new(Color3.new(color.r - .07, color.g - .07, color.b - .07))
				end
			end
			wait(.01)
		end
		--sink
		for i = 1, 90, 1 do
			p.Parent:SetPrimaryPartCFrame(p.Parent.PrimaryPart.CFrame * CFrame.Angles(math.rad(1), 0, 0))
			wait(.001)						
		end
		wait(.5)
		--continues sinking ship		
		for i = 1, 250, 1 do
			if p.Parent ~= nil then
				p.Parent:SetPrimaryPartCFrame(p.Parent.PrimaryPart.CFrame - Vector3.new(0, .1, 0))
				wait(.01)
			end						
		end	
		p.Parent:Destroy()
		start()
	end

	
	
	--shooting function
	function shoot()
		if shootDebounce == false then
			shootDebounce = true
			--bullet
			local frontVector = car.PrimaryPart.CFrame:vectorToWorldSpace(Vector3.new(0 , 0, -1))
			local b = Instance.new("Part", game.Workspace)
			b.Name = "Bullet"
			b.CanCollide = false
			b.FormFactor = Enum.FormFactor.Custom
			b.Size = Vector3.new(1.5, 1.5, 1.5)
			b.BrickColor = BrickColor.new("Black")
			b.Material = "Pebble"
			b.Shape = "Ball"
			b.Position = car.PrimaryPart.Position + car.PrimaryPart.CFrame.lookVector * 17
			local bHeight = b.Position.Y		
			local bForce = Instance.new("BodyVelocity", b)
			bForce.Velocity = Vector3.new(car.PrimaryPart.CFrame.lookVector.X * 200, 1, car.PrimaryPart.CFrame.lookVector.Z * 200)
			d:AddItem(b, 40)
			local shootSound = Instance.new("Sound", car.FirstBeveledBrick)
			shootSound.SoundId = "http://www.roblox.com/asset/?id=208259853"
			shootSound:Play()
			d:AddItem(shootSound, 5)
			--damage
			b.Touched:connect(function(hit)
				if hit.Parent ~= nil and hit.Parent:FindFirstChild("FirstBeveledBrick") ~= nil and hit.Parent.nameTag.Value ~= plr.Name and hurtDebounce == false then
					hurtDebounce = true
					local tag = Instance.new("Model", hit.Parent)
					tag.Name = plr.Name
					local identifier = Instance.new("IntValue", tag)
					hit.Parent.FirstBeveledBrick.HealthTag.Value = hit.Parent.FirstBeveledBrick.HealthTag.Value - 19
					wait(2)
					tag:Destroy()
					hurtDebounce = false
				end
			end)
			wait(2)
			local reloadingSound = Instance.new("Sound", car.FirstBeveledBrick)
			reloadingSound.SoundId = "http://www.roblox.com/asset/?id=200289834"
			reloadingSound:Play()
			d:AddItem(reloadingSound, 4)
			wait(1)
			shootDebounce = false
		end
		
	end
	
	
			
	
	
	--movement support
	input.InputBegan:connect(function(key, typing)
		--desktop keyboard
		if typing == false and car:FindFirstChild("DYING") == nil and wTag ~= nil and sTag ~= nil and aTag ~= nil and dTag ~= nil then
			if key.KeyCode == Enum.KeyCode.F then
				shoot()
			end
			if key.KeyCode == Enum.KeyCode.ButtonA then
				shoot()
			end
			if key.KeyCode == Enum.KeyCode.W or key.KeyCode == Enum.KeyCode.Up or key.KeyCode == Enum.KeyCode.DPadUp then			
				wTag.Value = true
				car.Motor.emitter.Enabled = true
			elseif key.KeyCode == Enum.KeyCode.S or key.KeyCode == Enum.KeyCode.Down then
				sTag.Value = true
			elseif key.KeyCode == Enum.KeyCode.A or key.KeyCode == Enum.KeyCode.Left then
				aTag.Value = true
			elseif key.KeyCode == Enum.KeyCode.D or key.KeyCode == Enum.KeyCode.Right then
				dTag.Value = true
			end
		end
		--controller shooting
		if key.KeyCode == Enum.KeyCode.ButtonA or key.KeyCode == Enum.KeyCode.ButtonR2 then
			shoot()
		end
	end) 
	input.InputEnded:connect(function(key, typing)
			if typing == false and wTag ~= nil and sTag ~= nil and aTag ~= nil and dTag ~= nil then
				
			if key.KeyCode == Enum.KeyCode.W or key.KeyCode == Enum.KeyCode.Up then
				wTag.Value = false
				car.Motor.emitter.Enabled = false
				if plr:FindFirstChild("contact") ~= nil then
					
				else
					local tag = Instance.new("Model", plr)
					tag.Name = "wwTag"
				end
			elseif key.KeyCode == Enum.KeyCode.S or key.KeyCode == Enum.KeyCode.Down then
				sTag.Value = false
				if plr:FindFirstChild("contact") ~= nil then
					
				else
					local tag = Instance.new("Model", plr)
					tag.Name = "ssTag"
				end
			elseif key.KeyCode == Enum.KeyCode.A or key.KeyCode == Enum.KeyCode.Left then
				aTag.Value = false
			elseif key.KeyCode == Enum.KeyCode.D or key.KeyCode == Enum.KeyCode.Right then
				dTag.Value = false
			end
		end
	end)
	
	--gamepad support
	input.InputChanged:connect(function(key, processed)
		if key.UserInputType == Enum.UserInputType.Gamepad1 then
			--left thumbstick
			if key.KeyCode == Enum.KeyCode.Thumbstick1 then
				if key.Position.Y >= .5 then
					wTag.Value = true
					sTag.Value = false
				elseif key.Position.Y <= -.5 then
					sTag.Value = true
					wTag.Value = false
				else
					sTag.Value = false
					wTag.Value = false
				end		
			end
			--right thumbstick
			if key.KeyCode == Enum.KeyCode.Thumbstick2 then
				if key.Position.X >= .5 then
					dTag.Value = true
					aTag.Value = false
				elseif key.Position.X <= -.5 then
					aTag.Value = true
					dTag.Value = false
				else
					aTag.Value = false
					dTag.Value = false
				end					
			end	
		end
	end)


	local deathDebounce = false
	local respawnDebounce = false
	rt.RenderStepped:connect(function()
		if car:FindFirstChild("FirstBeveledBrick") ~= nil then
			local h = car.FirstBeveledBrick.HealthTag.Value
			screenVal = (h / 100)
			if h <= .01 and deathDebounce == false then
				deathDebounce = true
				deathSeq(car.Part)
				wait(5)
				deathDebounce = false
			end
		end
		
		
		if screenVal ~= nil and car ~= nil and car.Parent == game.Workspace then
			car.MainSail.BillboardGui.slider:TweenSize(UDim2.new(screenVal, 0, 1, 0), "Out", "Quad", .4)
		end
						
		if car ~= nil and c ~= nil and car.PrimaryPart ~= nil and car:FindFirstChild("DYING") == nil then
			--camera position
			c.CameraType = Enum.CameraType.Scriptable
			local rightVector = car.PrimaryPart.CFrame:vectorToWorldSpace(Vector3.new(1, 0, 0))
			local backVector = car.PrimaryPart.CFrame:vectorToWorldSpace(Vector3.new(0 , 0, 1))
			local upVector = car.PrimaryPart.CFrame:vectorToWorldSpace(Vector3.new(0 , 1, 0))			
			local pos = car.PrimaryPart.Position + Vector3.new(0, 16, 0) + (rightVector * 11) + (backVector * 20) + (upVector * 2)
			local lookVect = car.PrimaryPart.Position
			c.CoordinateFrame = CFrame.new(pos, lookVect)
			c.FieldOfView = 85
			 
			
			
			--movement
			if wTag.Value == true then
				if plr:FindFirstChild("ssTag") == nil then 
					if speedVal <= .6 then
						speedVal = speedVal + 0.005
					end
					if plr:FindFirstChild("wwTag") ~= nil then
						plr:FindFirstChild("wwTag"):Destroy()
					end
					if plr:FindFirstChild("ssTag") ~= nil then
						plr:FindFirstChild("ssTag"):Destroy()
					end
				else
					if plr:FindFirstChild("wwTag") ~= nil then 
						plr:FindFirstChild("wwTag"):Destroy()
					end
					if speedVal > 0 then
						speedVal = speedVal - 0.005
						if speedVal <= 0 then
							plr:FindFirstChild("ssTag"):Destroy()
							speedVal = 0
						end
					end
					--RAYCASTING BACKWARDS	
					local ray = Ray.new(car.BackCSensor.Position, (-car.PrimaryPart.CFrame.lookVector * 300))
					local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
					bdistance = (car.FrontCSensor.Position - position).magnitude
					print(bdistance)
					if bdistance > 25 then
						--when you're going backwards, but you want to go forwards
						car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame - Vector3.new(car.PrimaryPart.CFrame.lookVector.X * speedVal, 0, car.PrimaryPart.CFrame.lookVector.Z * speedVal))					
						if plr:FindFirstChild("contact") ~= nil then
							plr:FindFirstChild("contact"):Destroy()
						end						
					else
						speedVal = 0
						if plr:FindFirstChild("contact") ~= nil then
						else
							local tag = Instance.new("Model", plr)
							tag.Name = "contact"
						end
						if plr:FindFirstChild("wwTag") ~= nil then
							plr:FindFirstChild("wwTag"):Destroy()
						end
						if plr:FindFirstChild("ssTag") ~= nil then
							plr:FindFirstChild("ssTag"):Destroy()
						end						
					end				
				end
				--RAYCASTING			
				local ray = Ray.new(car.FrontCSensor.Position, (car.PrimaryPart.CFrame.lookVector * 300))
				local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
				distance = (car.FrontCSensor.Position - position).magnitude
				if distance > 7 then
					--moving forward
					car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame + Vector3.new(car.PrimaryPart.CFrame.lookVector.X * speedVal, 0, car.PrimaryPart.CFrame.lookVector.Z * speedVal))			
					if plr:FindFirstChild("contact") ~= nil then
						plr:FindFirstChild("contact"):Destroy()
					end	
				else
					speedVal = 0
					if plr:FindFirstChild("contact") ~= nil then
					else
						local tag = Instance.new("Model", plr)
						tag.Name = "contact"
					end
					if plr:FindFirstChild("wwTag") ~= nil then
						plr:FindFirstChild("wwTag"):Destroy()
					end
					if plr:FindFirstChild("ssTag") ~= nil then
						plr:FindFirstChild("ssTag"):Destroy()
					end				
				end			
			elseif wTag.Value == false and plr:FindFirstChild("wwTag") ~= nil then
				if speedVal > 0 then
					speedVal = speedVal - 0.005
					if speedVal <= 0 then
						plr:FindFirstChild("wwTag"):Destroy()
						speedVal = 0
					end
				end	
				--RAYCASTING
				if distance > 4 then
					--glide forwards
					local ray = Ray.new(car.FrontCSensor.Position, (car.PrimaryPart.CFrame.lookVector * 300))
					local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
					distance = (car.FrontCSensor.Position - position).magnitude
					if distance > 4 then
						if plr:FindFirstChild("contact") ~= nil then
							plr:FindFirstChild("contact"):Destroy()
						end	
						car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame + Vector3.new(car.PrimaryPart.CFrame.lookVector.X * speedVal, 0, car.PrimaryPart.CFrame.lookVector.Z * speedVal))							
					else
						speedVal = 0
						if plr:FindFirstChild("contact") ~= nil then
						else
							local tag = Instance.new("Model", plr)
							tag.Name = "contact"
						end
						if plr:FindFirstChild("wwTag") ~= nil then
							plr:FindFirstChild("wwTag"):Destroy()
						end
						if plr:FindFirstChild("ssTag") ~= nil then
							plr:FindFirstChild("ssTag"):Destroy()
						end					
					end				
				end		
			end
			if sTag.Value == true then
				if plr:FindFirstChild("wwTag") == nil then
					if speedVal <= .6 then
						speedVal = speedVal + 0.005
					end		
					if plr:FindFirstChild("wwTag") ~= nil then
						plr:FindFirstChild("wwTag"):Destroy()
					end
					if plr:FindFirstChild("ssTag") ~= nil then
						plr:FindFirstChild("ssTag"):Destroy()
					end
				else
					if plr:FindFirstChild("ssTag") ~= nil then 
						plr:FindFirstChild("ssTag"):Destroy()
					end
					if speedVal > 0 then
						speedVal = speedVal - 0.005
						if speedVal <= 0 then
							plr:FindFirstChild("wwTag"):Destroy()
							speedVal = 0
						end
					end
					--when you're going forwards, but you want to go back
					--RAYCASTING
					local ray = Ray.new(car.FrontCSensor.Position, (car.PrimaryPart.CFrame.lookVector * 300))
					local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
					distance = (car.FrontCSensor.Position - position).magnitude
					if distance > 4 then
						car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame + Vector3.new(car.PrimaryPart.CFrame.lookVector.X * speedVal, 0, car.PrimaryPart.CFrame.lookVector.Z * speedVal))								
						if plr:FindFirstChild("contact") ~= nil then
							plr:FindFirstChild("contact"):Destroy()
						end	
					else
						speedVal = 0
						if plr:FindFirstChild("contact") ~= nil then
						else
							local tag = Instance.new("Model", plr)
							tag.Name = "contact"
						end
						if plr:FindFirstChild("wwTag") ~= nil then
							plr:FindFirstChild("wwTag"):Destroy()
						end
						if plr:FindFirstChild("ssTag") ~= nil then
							plr:FindFirstChild("ssTag"):Destroy()
						end	
					end				
				end	
					--RAYCASTING BACKWARDS	
					local ray = Ray.new(car.BackCSensor.Position, (-car.PrimaryPart.CFrame.lookVector * 300))
					local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
					bdistance = (car.FrontCSensor.Position - position).magnitude
					if bdistance > 25 then
						--moving backwards
						car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame - Vector3.new(car.PrimaryPart.CFrame.lookVector.X * speedVal, 0, car.PrimaryPart.CFrame.lookVector.Z * speedVal))									
						if plr:FindFirstChild("contact") ~= nil then
							plr:FindFirstChild("contact"):Destroy()
						end						
					else
						speedVal = 0
						if plr:FindFirstChild("contact") ~= nil then
						else
							local tag = Instance.new("Model", plr)
							tag.Name = "contact"
						end
						if plr:FindFirstChild("wwTag") ~= nil then
							plr:FindFirstChild("wwTag"):Destroy()
						end
						if plr:FindFirstChild("ssTag") ~= nil then
							plr:FindFirstChild("ssTag"):Destroy()
						end					
					end			
			elseif sTag.Value == false and plr:FindFirstChild("ssTag") ~= nil then
				if speedVal > 0 then
					speedVal = speedVal - 0.005
					if speedVal <= 0 then
						plr:FindFirstChild("ssTag"):Destroy()
						speedVal = 0
					end
				end	
				--RAYCASTING BACKWARDS	
				local ray = Ray.new(car.BackCSensor.Position, (-car.PrimaryPart.CFrame.lookVector * 300))
				local part, position = workspace:FindPartOnRay(ray, plr.Character, false, true)
				bdistance = (car.FrontCSensor.Position - position).magnitude
				if bdistance > 25 then
					--glide backwards
					car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame - Vector3.new(car.PrimaryPart.CFrame.lookVector.X * speedVal, 0, car.PrimaryPart.CFrame.lookVector.Z * speedVal))								
					if plr:FindFirstChild("contact") ~= nil then
						plr:FindFirstChild("contact"):Destroy()
					end					
				else
					speedVal = 0
					if plr:FindFirstChild("contact") ~= nil then
					else
						local tag = Instance.new("Model", plr)
						tag.Name = "contact"
					end
					if plr:FindFirstChild("wwTag") ~= nil then
						plr:FindFirstChild("wwTag"):Destroy()
					end
					if plr:FindFirstChild("ssTag") ~= nil then
						plr:FindFirstChild("ssTag"):Destroy()
					end				
				end
			end	
			if aTag.Value == true then
				car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(turnDeg), 0))
				car.Wheel:SetPrimaryPartCFrame(car.Wheel.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(-wheelTurnDeg), 0))			
			end
			if dTag.Value == true then
				car:SetPrimaryPartCFrame(car.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(-turnDeg), 0))
				car.Wheel:SetPrimaryPartCFrame(car.Wheel.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(wheelTurnDeg), 0))
			end
		end
	end)
	
	

	--camera rocking
	wait(.1)
	c:SetRoll(math.rad(-2))
	function camRock()
		if c.CameraType == Enum.CameraType.Scriptable and car:FindFirstChild("DYING") == nil then
			for i = -2, 1.5, .05 do
				c:SetRoll(math.rad(i))
				wait(.0001)
			end
			wait(.1)
			for i = 1.5 , -2, -.05 do
				c:SetRoll(math.rad(i))
				wait(.0001)
			end
			wait(.1)
			camRock()
		end
	end
	wait(.3)
	camRock()
end)
coroutine.resume(nthread)