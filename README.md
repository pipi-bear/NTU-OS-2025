# NTU CSIE: OS (2025)

This repository contains the <ins>MPs</ins> of the course **Operating System (2025) at NTU CSIE**, conducted by Prof. Daniel C.-S. Shih (odd class) and Prof. Fang-Jing Wu (even class).
> For both classes, we have the same MPs.

## Warnings & Grades

You can freely use the contents in this repo, however, note that:

:warning: **NOT ALL MPs ARE CORRECT**

So be careful not to directly hand in my incorrect version. For reference, my grades for each MP are as follows:

- MP0: 90 / 100
- MP1: 0 / 100
> I think I got zero point because I handed it in in a rush, so it might be the case that the final version could not successfully compile, maybe some of the contents are still useful (I cannot guarantee, so be careful using it anyways :sob:)
- MP2: 100 / 140
- MP3: 97 / 100

## How to use

In each MP, for most of the cases, we only need to modify one of the files, which would be under `MP*/mp*/xv6`, and mostly it would be either under `kernel` or `user`, anyways, detailed explanations of where to find the required file and the usage of other files for each MP are as below:  

---

### MP0

The only file that I handed in is:

`MP0/mp0/xv6/r13922136/mp0.c`

#### Spec

- `MP0/mp0.pdf`: Detailed instructions for MP1
- `MP0/mp0_slides.pdf`: Simplified introduction about this MP offered by the TAs

#### Additional information

Some really basic notes that I took could be found in the file: `MP0/MP0_notes.pdf`.

---

### MP1

Most of the things that we should implement would be covered in:

`MP1/mp1/xv6/r13922136/threads.c`

Note that in this MP, I remembered that <ins>more than one files should be modified</ins>, however, I did not remember which ones :sweat_smile:

Maybe one of them is: `MP1/mp1/xv6/threads.h`

#### Spec

- `MP1/MP1_2025-1.pdf`: Detailed instructions for MP1
- `MP1/Os 2025 MP1 Thread operation _.pdf`: Simplified introduction about this MP offered by the TAs

#### Additional information

- `MP1/MP1_notes.pdf`: mostly about some basic docker settings
> Like solving errors such as: "No rule to make target 'clean'. Stop."
- `MP1/setjmp_and_longjmp.pdf`: Some content explaining setjmp and longjmp that I downloaded from the Internet
- `MP1/setjmp(3) - Linux manual page.pdf`: Linux manual page for setjmp, which also gives some basic definition and explanation

---

### MP2

In this MP, the TA tried a new way to let us hand in our homework, which is uploading to our MP2 to a github repo (which is `mp2-` followed by each student's github account), so for mine, it is `mp2-pipi-bear`, which could be found under `MP2`.

The files that are modified in this MP:

- `MP2/mp2-pipi-bear/kernel/slab.c`
- `MP2/mp2-pipi-bear/kernel/syscall.c`
- `MP2/mp2-pipi-bear/kernel/syscall.h`

I forgot if there's any other file that has been modified :pensive:, so check other files if anything is working wrong.

#### Spec

- `MP2/MP2.pptx`: Simplified introduction about this MP offered by the TAs

#### Additional information

- `MP2/final_grade_with_O1-ab85efc1-8615-447c-b000-2d6586f19807.csv`: My grade for each part
- `MP2/mp2-clone-check`: This repo is the same as `MP2/mp2-pipi-bear`, which is just cloning to make sure if I correctly pushed my MP

---

### MP3

The only file that should be modified is:

`MP3/mp3/xv6/user/threads_sched.c`

#### Spec

- `MP3/MP3-4.pdf`: Detailed instructions for MP3
- `MP3/mp3.pptx.pdf`: Simplified instructions about this MP offered by the TAs

#### Additional information

- `MP3/MP3_README.md`: Some notes and explanations that I took for this MP
> :bulb: This could be helpful especially for the <ins>EDF-CBS scheduling algorithm</ins>, since some of the requirements are not clearly mentioned in the spec, and I recorded some of the replies from the TAs in the discussions section on NTUCool.
> - However, this readme file is only partially completed, so you could just scan over and find if anything could be useful.

--- 

### MP4

Many files needed modification in this MP, check the reademe in the MP4 directory `MP4_README.md`, in the top of the file, there's a screenshot showing the files contained in the patch (which we're required to hand in, and would indicate the files that needs modification), also, you can find what I've modified in the `r13922136.patch` file.

#### Spec

- `MP4/mp4.pdf`: Detailed instructions for MP4
- `MP4/mp4-slides.pdf`: Simplified instructions about this MP offered by the TAs

#### Additional information

- `MP4/MP4_README.md`: Some notes and explanations that I took for this MP

:warning: Note that this readme file is only partially completed, and might contain some incorrect content, since I do not have time to update all the content to align with the final version of my code.

However, some things could still be useful:
- Screenshot of the patch file content 
- Subsection "IMPORTANT MODIFICATION", which shows how to add permission field without modifying inode size
- I recorded some of the replies from the TAs in the discussions section on NTUCool. 

> In the end of the markdown file.

- For some functions that I'm not certain about the usage, like `namex`, or something that I'm not familiar with, like "user stub", I asked AI and find the reply useful, so I took screenshot and attached them in the readme. 