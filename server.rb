require 'webrick'

class OseroServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET req,res
    board=req.query['board'].split('.')
    reversible=req.query['reverse'].to_i

    solver_src=File.join(File.dirname(__FILE__),'solver.rb')
    load solver_src

    answer=Solver.new.solve(board,reversible)
    res['Content-Type']='text/plain'
    case answer.first
    when :put
      res.body=answer[1].join(',')
    when :reverse
      res.body='R'
    else
      raise 'wtf'
    end
  end
end

server = WEBrick::HTTPServer.new({
:Port => 10080,
:BindAddress => '127.0.0.1'})
server.mount('/', OseroServlet)
trap('INT') { server.shutdown }
server.start

