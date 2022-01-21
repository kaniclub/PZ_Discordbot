require 'socket'
require 'discordrb'
require 'rcon'

class PZrconBot
    
    def initialize
        @bot = Discordrb::Commands::CommandBot.new(client_id: ENV["CLIENT_ID"], token: ENV["TOKEN"], prefix: "/")
    end
    
    def start
        
        settings
        
        @bot.run
    end


    def settings
        
        ### コマンド（管理者専用） ###
        @bot.command :commands do |event,code|
            begin
                r = event.user.roles
                
                if r.include?(ENV["ADMIN_ROLE_ID"])
                    event.send_message("処理を実行中・・・")

                    rconrp = Rcon::Response.new(id: nil, type: nil, body: nil)

                    rconcl = Rcon::Client.new(host: ENV["RCON_HOST"], port: ENV["RCON_PORT"], password: ENV["RCON_PASS"])
                    rconcl.authenticate!
                    rconrp=rconcl.execute(code, wait: 0.25)
                    rconcl.end_session!

                    event.send_message("------------------------")
                    event.send_message(rconrp.body)
                    event.send_message("------------------------")
                    
                    event.send_message("処理が完了しました。")
                else
                    event.send_message("管理者権限がないので実行できませんでした。")
                end
            rescue => e
                event.send_message("例外発生し、処理を中断しました。")
                event.send_message(e.message)
            end
        end
        
        ### ホワイトリスト追加 ###
        @bot.command :adduser do |event,username,password|
            begin
                c = event.channel
                    
                if c.recipients.nil?
                    event.send_message("DMメッセージで送信してください。")
                else
                    if username.nil?
                        event.send_message("ユーザー名を入力してください。")
                    elsif password.nil?
                        event.send_message("パスワードを入力してください。")
                    elsif /\A[a-z0-9[.][_]]+\z/.match?(username)
                        if /\A[a-z0-9[.][_]]+\z/.match?(password)
                            ###ここに処理を書く
                            event.send_message("処理成功")
                        else
                        event.send_message("パスワードは半角英数字で入力してください。")
                        end
                    else
                        event.send_message("ユーザー名は半角英数字で入力してください。")
                    end
                end
            rescue => e
                event.send_message("例外発生し、処理を中断しました。")
                event.send_message(e.message)
            end
        end
        
        ### help ###
        @bot.command :help do |event|
            event.respond(help_message)
        end
        
    end
    
    def help_message
        message  = "/adduser　　: ホワイトリストに登録します。\n"
        message += "　　　　　　: 記述方式：/adduser␣ユーザー名 ␣パスワード\n"
        message += "　　　　　　: 入力はDMメッセージにて入力してください。\n"
        message += "　　　　　　: ユーザー名とパスワードは半角英数字で入力してください。\n"
        message += "/commands　: サーバーにコマンドを送信します。#管理者専用\n"
        message += "　　　　　　: 記述方式(例)：/commands players\n"
        message += "/help　 　　  : 登録さているコマンドを表示します。"
    end
    
end

pzrcon_bot = PZrconBot.new
pzrcon_bot.start