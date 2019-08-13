    extensions.math = {

        ["s"] = function(c, e)
            app.noop("MATH: Application started")
            app.playback("my/math-start")
            wrong = 0
            while 1 do
                readstatus = channel["READSTATUS"]:get() and channel["READSTATUS"]:get() or "empty"
                if readstatus == "HANGUP" then
                    app.noop("User disconected")
                    break
                end
                -- Загадываю новое число, если предыдущее было отвечено верно или если три раза ответили неверно
                if randdigit == nil or wrong > 3 then randdigit = math.random(1,99) end
                md = string.len(tostring(randdigit))
                app.saynumber(randdigit)
                app.read("readdigit", nil, md)
                local readdigit = channel["readdigit"]:get()
                app.noop("MATH: rand: " .. randdigit .. " , read: " .. readdigit .. ", wrong: " .. wrong)
                if randdigit == tonumber(readdigit) then
                    app.playback("my/success")
                    randdigit = nil
                    wrong = 0
                else
                    app.playback("my/wrong")
                    wrong = wrong + 1
                end
                app.wait(1)
            end

            app.hangup()
        end;

        ["777"] = function(c, e)
            app.noop("MATH: Application started " .. channel.CHANNEL("callid"):get())
            app.dumpchan()
            --app.playback("my/math-start")
            wrong = 0
            while 1 do
                readstatus = channel["READSTATUS"]:get() and channel["READSTATUS"]:get() or "empty"
                if readstatus == "HANGUP" then
                    app.noop("User disconected")
                    break
                end
                -- Загадываю новое число, если предыдущее было отвечено верно или если три раза ответили неверно
                if randdigit1 == nil or wrong > 3 then randdigit1 = math.random(2,5) end
                if randdigit2 == nil or wrong > 3 then randdigit2 = math.random(1,5) end
                md = string.len(tostring(randdigit))
                app.playback("calcit")
                app.saynumber(randdigit1)
                app.playback("plus")
                app.saynumber(randdigit2)
                md = string.len(tostring(randdigit1 + randdigit2))
                app.read("readdigit", nil, md)
                local readdigit = channel["readdigit"]:get()
                app.noop("MATH: rand1: " .. randdigit1 .. " , rand2: " .. randdigit2 .. " , read: " .. readdigit .. ", wrong: " .. wrong)
                if randdigit1 + randdigit2 == tonumber(readdigit) then
                    app.playback("my/success")
                    app.playback("sugar")
                    randdigit1 = nil
                    randdigit2 = nil
                    wrong = 0
                else
                    app.playback("my/wrong")
                    wrong = wrong + 1
                end
                app.wait(1)
            end

            app.hangup()
        end;

    };
