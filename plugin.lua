function run(msg)
	help_sudo = "*Sudo Commands:*\n______________________________\n"
.."/req\n   قائمة الرغبات\n\n"
  .."     /req>\n   لوحة المفاتيح قائمة الرغبات\n\n"
  .."     /sendtoall {text}\n   أرسل إلى جميع\n\n"
  .."     /users\n   کاربران ربات\n\n"
  .."     /info {text}\n   المستخدمين الروبوت\n\n"
  .."     /avatar {reply photo}\n   الصورة الرمزية الخاصة بك\n\n"
  .."     /block {id},{in chat}\n   حظر المستخدم\n\n"
  .."     /unblock {id}\n   رفع الحظر\n\n"
  .."     /blocklist\n    المحظورین\n\n"
  .."     /blocklist>\n   قائمه المحظورین\n\n"
  .."     /promote {id}\n   ضیف ادمن\n\n"
  .."     /demote {id}\n   نزل ادمن\n\n"
  .."     /friends\n    المسؤولين\n\n"
  .."     /friends>\n   قائمه المسؤولين\n\n"
  .."     /del {id}\n   مرفوض\n\n"
  .."     /chat {id}\n   بدء المحادثة\n\n"
  .."     /end\n   اطلع على المحادثة\n\n"
  .."     /spam {id,num,text}\n   البريد المزعج الآن\n\n"
  .."     /key\n   قائمه الادمن\n\n"
	about_txt = "مرحبا بکم علی بوت تواصل vip-"..bot_version.."\nمع اینلاین!\n\n`تقارير أيضا عن طريق الروبوت حتى لو كنت تستطيع البقاء على اتصال معنا. للقيام بذلك، ببساطة ترسل لنا دردشة السؤال والانتظار حتى ونحن نقبل به. يمكنك أن ترسل لنا من خلال المفتاح المطابق لرقم هاتفك للاتصال بك إذا لزم الأمر. يحتوي الروبوت أيضا قدرات أخرى، يمكنك أن تقرأ سيرة دينا، لدينا عدد من بوت الحصول على أو حتى في النسخة كبار الشخصيات من الروبوت يمكن أن ترسل لنا الرسائل القصيرة  ب.`"
	about_key = {{{text = "🌐تابع موقعنا🌐" , url = "https://telegram.me/lTSHAKEl_CH"}},{{text = "📢تابع قناتنا📢" , url = "https://telegram.me/lTSHAKEl_CH"}},{{text = "👤بوت تواصل تبع المطور👤" , url = "https://telegram.me/farhanibot"}},{{text = "👤مهندس عماد فرهانی مقدم👤" , url = "https://telegram.me/Emad_farhani"}},{{text = "👥مجموعه دعم👥" , url = "https://telegram.me/joinchat/DESC_T93cn-ciJU_etqA"}}}
	start_txt = "مرحبا صدیقی\n\n`من خلال هذا الروبوت حتى لو كنت ويمكن أيضا التواصل تقارير معنا. ايحتوي الروبوت أيضا على وظائف أخرى من لوحة المفاتيح أدناه يمكنك العثور عليها. مطور البوت المطور @emad_farhani`"
	start_key = {{{text="👤مهندس عماد فرهانی مقدم👤",url="https://telegram.me/Emad_farhani"}}}
	keyboard = {{"🔖طلب محادثة🔖"},{{text="📱أرسل لنا رقم هاتفك📱",request_contact=true},{text="🗺أرسل لنا موقعك🗺",request_location=true}},{"👤رقم هاتفنا👤","📩أرسل رسالة📩"},{"👤معلوماتنا👤","🔃النسخة الروبوت🔃"..bot_version}}
	------------------------------------------------------------------------------------
	blocks = load_data("blocks.json")
	chats = load_data("chats.json")
	requests = load_data("requests.json")
	contact = load_data("contact.json")
	location = load_data("location.json")
	users = load_data("users.json")
	admins = load_data("admins.json")
	setting = load_data("setting.json")
	userid = tostring(msg.from.id)
	msg.text = msg.text:gsub("@"..bot.username,"")
	
	if msg.chat.id == admingp then
	elseif msg.chat.type == "channel" or msg.chat.type == "supergroup" or msg.chat.type == "group" then
		return
	end
	
	if not users[userid] then
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start_txt, start_key)
		return send_key(msg.from.id, "`لوحة المفاتيح الرئيسية:`❗️", keyboard)
	end
	
	if msg.text == "/start" then
		users[userid] = true
		save_data("users.json", users)
		send_inline(msg.from.id, start_txt, start_key)
		return send_key(msg.from.id, "`لوحة المفاتيح الرئيسية:`🔘", keyboard)
	elseif msg.contact then
		if chats.id == msg.from.id then
		else
			if contact[userid] then
				if contact[userid][msg.contact.phone_number] then
					return send_msg(msg.from.id, "`كنت بالفعل قد ارسلت هاذا الرقم`❗️\n❗️*You sent this number ago*", true)
				else
					if #contact[userid] > 10 then
						return send_msg(msg.from.id, "`أنت لم تعد قادرة على ارسال رقم الخاص بك!`❗️\n❗️*You Can't send new number!*", true)
					end
					table.insert(contact[userid], msg.contact.phone_number)
					save_data("contact.json", contact)
					send_msg(msg.from.id, "`تم تسلیم رقمک شکرا`❗️\n❗️*You'r number Sent*", true)
					send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
					return send_fwrd(admingp, msg.from.id, msg.message_id)
				end
			else
				contact[userid] = {}
				table.insert(contact[userid], msg.contact.phone_number)
				save_data("contact.json", contact)
				send_msg(msg.from.id, "`تم تسلیم رقمک شکرا`✔️\n✔️*You'r number Sent*", true)
				send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
				return send_fwrd(admingp, msg.from.id, msg.message_id)
			end
		end
	elseif msg.location then
		if chats.id == msg.from.id then
		else
			if location[userid] then
				if location[userid][msg.location.longitude] then
					return send_msg(msg.from.id, "`كنت قد أرسلت في وقت سابق هاذا الموقع`❗️\n❗️*You sent this location ago*", true)
				else
					if #location[userid] > 10 then
						return send_msg(msg.from.id, "`لا يمكنك إرسال موقع آخر!`❗️\n❗️*You Can't send new location!*", true)
					end
					table.insert(location[userid], msg.location.longitude)
					save_data("location.json", location)
					send_msg(msg.from.id, "`تم إرسال موقعك`✔️\n✔️*You'r location Sent*", true)
					send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
					return send_fwrd(admingp, msg.from.id, msg.message_id)
				end
			else
				location[userid] = {}
				table.insert(location[userid], msg.location.longitude)
				save_data("location.json", location)
				send_msg(msg.from.id, "`تم إرسال موقعك`✔️\n✔️*You'r location Sent*", true)
				send_msg(admingp, (msg.from.first_name or "").." "..(msg.from.last_name or "").." [@"..(msg.from.username or "-----").."] ("..msg.from.id..")", false)
				return send_fwrd(admingp, msg.from.id, msg.message_id)
			end
		end
	elseif msg.text:find("/spam") and msg.chat.id == admingp then
		local target = msg.text:input()
		if target then
			local target = target:split(",")
			if #target == 3 then
				send_msg(admingp, "❗️*Your target Spamming*", true)
				for i=1,tonumber(target[2]) do
					send_msg(tonumber(target[1]), target[3])
				end
				return send_msg(admingp, "❗️*Spamming Stoped*", true)
			elseif #target == 2 then
				send_msg(admingp, "❗️*Your target Spamming*", true)
				for i=1,tonumber(target[2]) do
					send_msg(tonumber(target[1]), "norton team\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nnorton Team")
				end
				return send_msg(admingp, "❗️*Spamming Stoped*", true)
			else
				send_msg(admingp, "❗️*Your target Spamming*", true)
				for i=1,100 do
					send_msg(tonumber(target[1]), "norton team\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nnorton Team")
				end
				return send_msg(admingp, "❗️*Spamming Stoped*", true)
			end
		else
			return send_msg(admingp, "`تذکر امام هاذا الامر حط ایدی الشخص`\n*after this command type Target ID*", true)
		end
	elseif msg.text:find("/sendtoall") and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			i=0
			for k,v in pairs(users) do
				i=i+1
				send_key(tonumber(k), usertarget, keyboard)
			end
			return send_msg(admingp, "`رسالتك الی"..i.." تم تسلیمها`\n*yor message Sent to "..i.." people*", true)
		else
			return send_msg(admingp, "`بعد هاذا الامر اکتب رسالتک`\n*after this command type Your Message*", true)
		end
	elseif msg.text == "/contact" or msg.text:lower() == "my contact" or msg.text == "👤رقم هاتفنا👤" then
		return send_phone(msg.from.id, "+"..sudo_num, sudo_name)
	elseif msg.text == "/users" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(users) do
			i=i+1
			list = list..i.."- *"..k.."*\n"
		end
		return send_msg(admingp, "*Users list:\n\n*"..list, true)
	elseif msg.text == "/blocklist>" and msg.chat.id == admingp then
		local list = {{"/key"}}
		for k,v in pairs(blocks) do
			if v then
				table.insert(list, {"/unblock "..k})
			end
		end
		return send_key(admingp, "*For unblock select a item:*", list, true)
	elseif msg.text == "/blocklist" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(blocks) do
			if v then
				i=i+1
				list = list..i.."- *"..k.."*\n"
			end
		end
		return send_msg(admingp, "*Block list:\n\n*"..list, true)
	elseif msg.text == "/friends>" and msg.chat.id == admingp then
		local list = {{"/key"}}
		for k,v in pairs(admins) do
			if v then
				table.insert(list, {"/demote "..k})
			end
		end
		return send_key(admingp, "*For demote a friends select a item:*", list, true)
	elseif msg.text == "/friends" and msg.chat.id == admingp then
		local list = ""
		i=0
		for k,v in pairs(admins) do
			if v then
				i=i+1
				list = list..i.."- *"..k.."*\n"
			end
		end
		return send_msg(admingp, "*Friends list:\n\n*"..list, true)
	elseif msg.text == "/req>" and msg.chat.id == admingp then
		local list = {{"/key"}}
		for k,v in pairs(requests) do
			if v then
				table.insert(list, {"/chat"..k,"/del"..k,"/block"..k})
			end
		end
		return send_key(admingp, "*For accept or delete request select a item:*", list, true)
	elseif msg.text == "/req" or msg.text:lower() == "chat request" or msg.text == "🔖طلب محادثة🔖" then
		if msg.chat.id == admingp then
			local list = ""
			i=0
			for k,v in pairs(requests) do
				if v then
					i=i+1
					list = list..i.."- *"..k.."*\n"
				end
			end
			return send_msg(admingp, "*Request list:\n\n*"..list, true)
		else
			if requests[userid] then
				return send_msg(msg.from.id, "`کنت بالفعل قد ارسلت طلب محادثه یرجی الانتظار وسوف نقوم بالرد شکرا`❗️\n❗️*You have Open Request please wait*", true)
			elseif msg.from.id == chats.id then
				return send_msg(msg.from.id, "`!!راح اقوله!!`", true)
			else
				requests[userid] = true
				save_data("requests.json", requests)
				send_msg(msg.from.id, "`تم إرسال طلبك، یرجی الانتظار شکرا`✔️\n✔️*You'r request Sent, please wait*", true)
				local text = " لديك طلب الدردشة من:\nYou have chat request of this user:\n\n"
				.."Name: "..(msg.from.first_name or "").." "..(msg.from.last_name or "").."\nUser: @"..(msg.from.username or "-----").."\nID: "..msg.from.id.."\n\n"
				--.."برای پزیرش گزینه ی اول را ارسال کنید، برای رد گزینه ی دوم را و برای بلاک کردن گزینه ی سوم را:\nfor accept press first option or for delete request press option 2 and for block user, press option 3:\n\n"
				.."1- /chat"..msg.from.id.."\n\n2- /del"..msg.from.id.."\n\n3- /block"..msg.from.id
				if not msg.from.username then
					send_fwrd(admingp, msg.from.id, msg.message_id)
				end
				return send_msg(admingp, text, false)
			end
		end
	elseif msg.text == '/sms' or msg.text:lower() == "send sms" or msg.text == "📩أرسل رسالة📩" then
		if admins[userid] then
			if msg.reply_to_message then
				if msg.reply_to_message.from.id == bot.id then
					return send_msg(msg.from.id, "`هاذا الامر /sms استخدمه بل ریپلی و اکتب رسالتک شکرا`\n*Reply this command or /sms on a message*", true)
				end
				if msg.reply_to_message.text == false or msg.reply_to_message.text == nil or msg.reply_to_message.text == "" or msg.reply_to_message.text == " " then
					return send_msg(admingp, "`قادرا على إرسال رسالة نصية فقط.`❗️", true)
				end
				if string.len (msg.reply_to_message.text) > 150 then
					return send_msg(msg.from.id, "`هاذا الامر /sms استخدمه بل ریپلی و اکتب رسالتک شکرا`❗️\n❗️*You'r message Sent, _don't send again*", true)
				end
				send_sms("00"..sudo_num, "[@"..(msg.from.username or "-----").."] ("..msg.from.id..")\n\n"..msg.reply_to_message.text)
				return send_msg(msg.from.id, "`تم إرسال رسالتك، لا ترسل رسائل اخری حتی نجیب`❗️\n❗️*You'r message Sent, don't send again*", true)
			else
				return send_msg(msg.from.id, "`هاذا الامر /sms استخدمه بل ریپلی و اکتب رسالتک شکرا`❗️\n❗️*Reply this command or /sms on a message*", true)
			end
		else
			return send_msg(msg.from.id, "`انت لا تکون من اصدقاء و لا یمکنت تستخدم هذه الخدمه`❗️\n❗️*You are Not My Friend and you not allow for use this command*", true)
		end
	elseif msg.text == "/key" and msg.chat.id == admingp then
		adminkey = {{"/end","/help","/block"},{"/req>","/req","/users"},{"/blocklist>","/blocklist"},{"/friends>","/friends"}}
		return send_key(admingp, "*Admin Keyboard:*", adminkey, true)
	elseif msg.reply_to_message and msg.text == "/avatar" and msg.chat.id == admingp then
		if msg.reply_to_message.photo then
			local i = #msg.reply_to_message.photo
			local photo_file = msg.reply_to_message.photo[i].file_id
			local url = send_api.."/getFile?file_id="..photo_file
			local file = https.request(url)
			local file = json.decode(file)
			local url = "https://api.telegram.org/file/bot"..bot_token.."/"..file.result.file_path
			local file = https.request(url)
			f = io.open("./avatar.webp", "w+")
			f:write(file)
			f:close()
			return send_msg(admingp, "`تم حفظ الصورة الرمزية`\n*You'r avatar Saved*", true)
		end
	elseif msg.text:find("/info") or msg.text:lower() == "my info" or msg.text == "👤معلوماتنا👤" then
		if msg.chat.id == admingp then
			local usertarget = msg.text:input()
			if usertarget then
				local file = io.open("./about.txt", "w")
				file:write(usertarget)
				file:flush()
				file:close() 
				return send_msg(admingp, "`تم حفظ النص فی معلوماتک`❗️\n❗️*You'r information Saved*", true)
			else
				return send_msg(admingp, "`بعد هاذا الامر ادخل النص تبع معلوماتک`❗️\n❗️*after this command type Your Information*", true)
			end
		else
			local f = io.open("./about.txt")
			if f then
				s = f:read('*all')
				f:close()
				infotxts = "`معلوماتنا:`\n"..s.."\n\n"
			else
				infotxts = ""
			end
			bioinfo = infotxts.."*Name:* "..sudo_name.."\n*Username:* [@"..sudo_user.."](https://telegram.me/"..sudo_user..")\n*Mobile:* +"..sudo_num.."\n*Telegram ID:* "..sudo_id.."\n*Channel:* [@"..sudo_ch.."](https://telegram.me/"..sudo_ch..")\n\n_Powered by_ [NORTONteam](https://telegram.me/telenorton_ch)"
			send_msg(msg.chat.id, bioinfo, true)
			local f = io.open("./avatar.webp")
			if f then
				send_document(msg.chat.id, "./avatar.webp")
			end
			return
		end
	elseif msg.text:find('/promote') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`هاذا الشخص محظور`❗️\n❗️*You'r target are Block*", true)
			end
			admins[tostring(usertarget)] = true
			save_data("admins.json", admins)
			send_msg(tonumber(usertarget), "`تم اختیارک کصدیق مفضل`✔️\n✔️*You promoted to Best Friend*", true)
			return send_msg(admingp, "`تم اختیار هاذا الشخص کصدیق`\n*You'r target promoted to Best Friend*", true)
		else
			return send_msg(admingp, "`بعد هاذا الامر ضع ایدی الشخص`❗️\n❗️*after this command type Target ID*", true)
		end
	elseif msg.text:find('/demote') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`هاذا الشخص محظور`❗️\n❗️You'r target are Block*", true)
			end
			admins[tostring(usertarget)] = false
			save_data("admins.json", admins)
			send_msg(tonumber(usertarget), "`انت بلفعل لم تکن صدیقنا`❗️\n❗️*You demoted of Best Friend*", true)
			return send_msg(admingp, "`هاذا الشخص بلفعل لم یکن صدیقک`❗️\n❗️*You'r target demoted of Best Friend*", true)
		else
			return send_msg(admingp, "`بعد هاذا الامر ضع ایدی الشخص`❗️\n❗️*after this command type Target ID*", true)
		end
	elseif msg.text:find('/block') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if tonumber(usertarget) == sudo_id or tonumber(usertarget) == bot.id then
				return send_msg(admingp, "`لا تقدر علی ان تحظر نفسک`❗️\n❗️*You can't block You'r Self*", true)
			end
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`هاذا الشخص بلفعل محظور`❗️\n❗️*You'r target are Block*", true)
			end
			blocks[tostring(usertarget)] = true
			save_data("blocks.json", blocks)
			send_msg(tonumber(usertarget), "`تم حظرک من البوت`❗️\n❗️*You are Blocked!*", true)
			send_msg(admingp, "`تم حظر هاذا الشخص`❗️\n❗️*You'r target Blocked*", true)
			if requests[tostring(usertarget)] then
				requests[tostring(usertarget)] = false
				save_data("requests.json", requests)
				send_msg(tonumber(usertarget), "`تم رفض طلب الدردشة`❗️\n❗️*You'r chat request Deleted*", true)
				send_msg(admingp, "`تم رفض طلب دردشه هاذه الشخص`❗️\n❗️*You'r target chat request Deleted*", true)
			elseif chats.id == tonumber(usertarget) then
				chats.id = 0
				save_data("chats.json", chats)
				send_msg(tonumber(usertarget), "`تم اغلاق الدردشه`🔚\n🔚*You'r chatroom Closed*", true)
				send_msg(admingp, "`تم اغلاق الدردشه`🔚\n🔚*You'r chatroom Closed*", true)
			end
			return
		else
			if chats.id > 0 then
				blocks[tostring(chats.id)] = true
				save_data("blocks.json", blocks)
				send_msg(chats.id, "`تم حظرک من البوت`❗️\n❗️*You are Blocked!*", true)
				send_msg(admingp, "`تم حظر هاذا الشخص`❗️\n❗️*You'r target Blocked*", true)
				chats.id = 0
				save_data("chats.json", chats)
				send_msg(chats.id, "`تم اغلاق الدردشه`🔚\n🔚*You'r chatroom Closed*", true)
				return send_msg(admingp, "`تم اغلاق الدردشه`🔚\n🔚*You'r chatroom Closed*", true)
			else
				if msg.text == "/block" then
					return send_msg(admingp, "`بعد هاذا الامر ضع ایدی الشخص`❗️\n❗️*after this command type Target ID*", true)
				else
					local usertarget = msg.text:gsub("/block","")
					if tonumber(usertarget) == sudo_id or tonumber(usertarget) == bot.id then
						return send_msg(admingp, "`لا تقدر علی ان تحظر نفسک`❗️\n❗️*You can't block You'r Self*", true)
					end
					if blocks[tostring(usertarget)] then
						return send_msg(admingp, "`هاذا الشخص بالفعل محظور`❗️\n❗️*You'r target are Block*", true)
					end
					blocks[tostring(usertarget)] = true
					save_data("blocks.json", blocks)
					send_msg(tonumber(usertarget), "`تم حظرک من البوت`❗️\n❗️*You are Blocked!*", true)
					send_msg(admingp, "`تم حظر هاذا الشخص`❗️\n❗️*You'r target Blocked*", true)
					if requests[tostring(usertarget)] then
						requests[tostring(usertarget)] = false
						save_data("requests.json", requests)
						send_msg(tonumber(usertarget), "`تم رفض طلب الدردشة`❗️\n❗️*You'r chat request Deleted*", true)
						send_msg(admingp, "`تم رفض طلب دردشه هاذه الشخص`❗️\n❗️*You'r target chat request Deleted*", true)
					elseif chats.id == tonumber(usertarget) then
						chats.id = 0
						save_data("chats.json", chats)
						send_msg(tonumber(usertarget), "`تم اغلاق الدردشه`🔚\n🔚*You'r chatroom Closed*", true)
						send_msg(admingp, "`تم اغلاق الدردشه`🔚\n🔚*You'r chatroom Closed*", true)
					end
					return
				end
			end
		end
	elseif msg.text:find('/unblock') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				blocks[tostring(usertarget)] = false
				save_data("blocks.json", blocks)
				send_msg(tonumber(usertarget), "`تم الغا حظرک من البوت`❗️\n❗️*You are Unblocked!*", true)
				return send_msg(admingp, "`تم الغا حظر هاذا الشخص من البوت`❗️\n❗️*You'r target Unblocked*", true)
			end
			return send_msg(admingp, "`هاذا الشخص لیس محظور`❗️\n❗️*You target Not Block*", true)
		else
			return send_msg(admingp, "`بعد هاذا الامر ضح ایدی الشخص`❗️\n❗️*after this command type Target ID*", true)
		end
	elseif msg.text:find('/del') and msg.chat.id == admingp then
		local usertarget = msg.text:input()
		if usertarget then
			if requests[tostring(usertarget)] then
				requests[tostring(usertarget)] = false
				save_data("requests.json", requests)
				send_msg(tonumber(usertarget), "`تم رفض طلب الدردشة`❗️\n❗️*You'r chat request Deleted*", true)
				return send_msg(admingp, "`تم رفض طلب دردشه هاذه الشخص`❗️\n❗️*You'r target chat request Deleted*", true)
			else
				return send_msg(admingp, "`لا یوجد طلب محادثه من هاذا الشخص`❗️\n❗️*You'r target Have Not chat request*", true)
			end
		else
			if msg.text == "/del" then
				return send_msg(admingp, "`بعد هاذا الامر ضع ایدی`❗️\n❗️*after this command type Target ID*", true)
			else
				local usertarget = msg.text:gsub("/del","")
				if requests[tostring(usertarget)] then
					requests[tostring(usertarget)] = false
					save_data("requests.json", requests)
					send_msg(tonumber(usertarget), "`تم رفض طلب الدردشة`❗️\n❗️*You'r chat request Deleted*", true)
					return send_msg(admingp, "`تم رفض طلب دردشه هاذه الشخص`❗️\n❗️*You'r target chat request Deleted*", true)
				else
					return send_msg(admingp, "`لا یوجد طلب محادثه من هاذا الشخص`❗️\n❗️*You'r target Have Not chat request*", true)
				end
			end
		end
	elseif msg.text:find('/chat') and msg.chat.id == admingp then
		if chats.id > 0 then
			return send_msg(admingp, "`لدیک دردشة مفتوحه، یرجی إغلاقه أولا`❗️\n❗️*You have Open Chat, first send* /end", true)
		end
		local usertarget = msg.text:input()
		if usertarget then
			if blocks[tostring(usertarget)] then
				return send_msg(admingp, "`هاذا الشخص بلفعل محظور`❗️\n❗️*You'r target are Block*", true)
			end
			requests[tostring(usertarget)] = false
			save_data("requests.json", requests)
			chats.id = tonumber(usertarget)
			save_data("chats.json", chats)
			send_msg(tonumber(usertarget), "`تم بدء الدردشه یمکنک البدء فی المحادثه`✔️\n✔️*Chat Started*", true)
			return send_msg(admingp, "`بدأ الدردشة`✔️\n✔️*Chat Started*", true)
		else
			if msg.text == "/chat" then
				return send_msg(admingp, "`بعد هاذا الامر ضع ایدی`❗️\n❗️*after this command type Target ID*", true)
			else
				local usertarget = msg.text:gsub("/chat","")
				if blocks[tostring(usertarget)] then
					return send_msg(admingp, "`هاذا الشخص بلفعل محظور`❗️\n❗️*You'r target are Block*", true)
				end
				requests[tostring(usertarget)] = false
				save_data("requests.json", requests)
				chats.id = tonumber(usertarget)
				save_data("chats.json", chats)
				send_msg(tonumber(usertarget), "`تم بدء الدردشه یمکنک البدء فی المحادثه`✔️\n✔️*Chat Started*", true)
				return send_msg(admingp, "`بدأ الدردشة`✔️\n✔️*Chat Started*", true)
			end
		end
	elseif msg.text == "/end" and msg.chat.id == admingp then
		if chats.id == 0 then
			return send_msg(admingp, "`لا یوجد دردشة مفتوحة`❗️\n❗️*You haven't Open Chat*", true)
		end
		send_msg(admingp, "`الدردشة مع "..chats.id.." تم اغلاقها`❗️\n❗️*Chat with "..chats.id.." Closed*", true)
		send_msg(chats.id, "`تم اغلاق الدردشه`❗️\n❗️*Chat Closed*", true)
		chats.id = 0
		save_data("chats.json", chats)
		return
	elseif msg.text == "/help" or msg.text:lower() == "help" or msg.text == "الاوامر" then
		if msg.chat.id == admingp then
			return send_msg(admingp, help_sudo, true)
		else
			return send_inline(msg.chat.id, about_txt, about_key)
		end
	elseif msg.text == "/about" or msg.text:lower() == "about v"..bot_version or msg.text == "🔃النسخة الروبوت🔃"..bot_version then
		return send_inline(msg.chat.id, about_txt, about_key)
	end
---------------------------------------------------------------------------------------------------------------------------------------------------
	if msg.chat.id == admingp and chats.id > 0 then
		return send_fwrd(chats.id, msg.chat.id, msg.message_id)
	elseif msg.chat.id == admingp and chats.id == 0 then
		return send_msg(admingp, "`لا یوجد دردشه مفتوحه`❗️\n❗️*You haven't Open Chat*", true)
	end
	if msg.from.id == chats.id then
		return send_fwrd(admingp, msg.from.id, msg.message_id)
	else
		if requests[tostring(msg.from.id)] then
			return send_msg(msg.from.id, "`یرجی الانتظار حتی نجیب علی طلبک شکرا`❗️\n❗️*Please wait for "..sudo_name.." Accept You*", true)
		else
			return send_msg(msg.from.id, "`ارسال بالاول طلب محادثه`❗️\n❗️*First send chat request with* /req", true)
		end
	end
end

function inline(msg)
	thumb = "http://umbrella.shayan-soft.ir/inline_icons/"
	local f = io.open("./about.txt")
	if f then
		s = f:read('*all')
		f:close()
		infotxtin = "`بیوگرافی:\n`"..s.."\n\n"
	else
		infotxtin = ""
	end
	bioinfo = infotxtin.."*Name:* "..sudo_name.."\n*Username:* [@"..sudo_user.."](https://telegram.me/"..sudo_user..")\n*Mobile:* +"..sudo_num.."\n*Telegram ID:* "..sudo_id.."\n*Channel:* [@"..sudo_ch.."](https://telegram.me/"..sudo_ch..")\n\n_Powered by_ [nprtonTEAM](https://telegram.me/TeleNorton_ch)"
	tabless = '[{"text":"حسابي الرئيسي","url":"https://telegram.me/'..sudo_user..'"}],[{"text":"قناتی  ","url":"https://telegram.me/'..sudo_ch..'"}],[{"text":"قناه المطور","url":"https://telegram.me/lTSHAKEl_CH"},{"text":"مطور البوت","url":"https://telegram.me/Emad_farhani"}]'
	info_inline = '{"type":"article","parse_mode":"Markdown","id":"2","title":"معلوماتی","description" كل ما يجب أن تعرفه عن لي...","message_text":"'..bioinfo..'","thumb_url":"'..thumb..'pv_bio.png","reply_markup":{"inline_keyboard":['..tabless..']}}'
	phone_inline = '{"type":"contact","id":"1","phone_number":"'..sudo_num..'","first_name":"'..sudo_name..'","last_name":"","thumb_url":"'..thumb..'pv_phone.png"},'
	return send_req(send_api.."/answerInlineQuery?inline_query_id="..msg.id.."&is_personal=true&cache_time=1&results="..url.escape('['..phone_inline..info_inline..']'))
end

return {launch = run, inline = inline}