# ECE253-Labs
We learned Verilog in ECE253 through a series of labs. Included here are the lab guides and our submissions for each. Shoutout to Parth Dua for being my partner.

Steps on Submission (for future students):
* See Steps_to_connect_to_ECF_computers_remotely.pdf
1. Connect to remote ECF desktop (see PDF for remote connection, or log onto lab computers directly).

* See ece253_submit_2021.pdf
2. Open WinSCP, you will be prompted for three fields: Host name, User name, Password.
3. Your Host name is ug132.eecg.utoronto.ca (or anything from 132 to ug180.eecg.utoronto.ca).
4. Your User name is your UTORid.
5. Your Password is your student number (i.e. 100#######). 
6. Click "Login", and trust the host.
7. On the right section (the one that's not "\\srvd\homes$\"), copy-paste the files you wish to submit (i.e. part1.v, part2.v, part3.v).
8. You have now successfully transferred your files to the UG Machine! Now to submit them for grading.

* See ece253_submit_2021.pdf
9. Open PuTTY, use ug132.eecg.utoronto.ca as your login, click "Open".
10. In the "login as: " field, enter your UTORid.
11. Your password is your student number again. Note that this is Linux, so you will not be able to see it when you write it. Just write it and hit Enter.
12. If successful, you should see a prompt "ug132:~%".
13. To run sanity check (i.e. tester), copy-paste "/cad2/ece241f/public/<lab#>/tester" and change the "<lab#>" to the lab you're doing.
    i.e. /cad2/ece241f/public/4/tester
14. Once you are satisfied with your results, copy-paste "submitece253f <lab#> part1.v part2.v part3.v", and change things accordingly.
15. To check that you have submitted, copy-paste "submitece253f -l <lab#>" and change "<lab#>".
    * Note that if you can't see the text after copy-pasting, right click on the terminal and it should show up.
Good luck!
