require "./TelegramSanBot/*"
require "TelegramBot"

module TelegramSanBot
    class SanBot < TelegramBot::Bot
        include TelegramBot::CmdHandler

        def san(input : String, separator : String)
            san = String.new
            input.each_char do |char|
                if char != 'e' && char != 'E'
                    san += "#{char}#{separator}"
                end
            end
            san
        end

        def initialize(@token)
            super("SanBot", @token)

            cmd "san" do |msg, params|
                sanned = String.new
                params.each { |word| sanned += "#{san(word, "")} " }
                reply msg, sanned
            end

            cmd "sans" do |msg, params|
                sanned = String.new
                params.each { |word| sanned += "#{san(word, " ")} " }
                reply msg, sanned
            end
        end
    end

    san_bot = SanBot.new ENV["SAN_TELEGRAM_TOKEN"]
    san_bot.polling
end
