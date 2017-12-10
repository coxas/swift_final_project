# actual_final

A description of this package.

I had to create this other repository because I had problems with git in the one in GitHub classroom. Something with submodules?

This project does not compile in XCode. There is an error in the package.swift file that I could not fix. It does, however, run on the command line. Navigate to sources/actual_final. The main.swift and networking.swift files are there. Do swift build and swift run. You will see the prompt.

One problem that I had in the homeworks, and that reoccured here, is that after a call to the API is made, it doesn't exit. So it does not ever ask the user if they want to run another query or if they want to quit the program. I believe this has something to do with the call to dispatchMain( ). I removed that to test my while loop. The while loop does function correctly--it allows the user to make another call or exit the program.

I had similar problems with the unit tests in the executable package. I can't run my unit tests because the code does not compile in XCode. But I wrote them, and they are there under Tests/tests_actual_final. You will be able to see the code if you open the XCode project link.

I did all the requirements except persisting data to disk. Trying to do that broke everything, so I left it out. But I wrote code for everything else, even if it doesn't completely work. 
