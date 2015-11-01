
local io      = io
local assert  = assert
local naughty = naughty

module("task_data")

function displayTasks(tasks_sorting)
	local execute_command
	if tasks_sorting == "cpu" then
		execute_command = "ps -eo pcpu,pmem,pid,user,comm | sort -k 1 -r | head -10"
	elseif (tasks_sorting == "mem") then
		execute_command = "ps -eo pmem,pcpu,pid,user,comm | sort -k 1 -r | head -10"
	end

	local top_data = assert(io.popen('top -b -n1 | head -n 5'))  -- | head -n 12
	local top_str  = top_data:read('*all')
	top_data:close()

	local ps_data = assert(io.popen(execute_command))
	local ps_str  = ps_data:read('*all')
	ps_data:close()
	

        naughty.notify({
                text = top_str .. "\n" .. ps_str,
                timeout = 0,
                hover_timeout = 0.5,
		opacity = 0.8
        })

end
