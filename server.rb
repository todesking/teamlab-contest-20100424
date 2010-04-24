require 'webrick'

class OseroServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET req,res
    board=req.query['board'].split('.')
    reversible=req.query['reverse'].to_i

    puts
    puts '==============='
    puts board
    puts 'size:'+[board.first.length,board.length].join(',')
    puts 'reversible: '+reversible.to_s

    solver_src=File.join(File.dirname(__FILE__),'solver.rb')
    load solver_src

    answer=Solver.new.solve(board,reversible)

    puts 'answer: '+answer.inspect

    res['Content-Type']='text/plain'
    case answer.first
    when :put
      res.body=answer[1].reverse.join(',')
    when :reverse
      res.body='R'
    else
      raise 'wtf'
    end
  end
end

server = WEBrick::HTTPServer.new({
:Port => 8080,
:BindAddress => '0.0.0.0'})
server.mount('/', OseroServlet)
trap('INT') { server.shutdown }
server.start

