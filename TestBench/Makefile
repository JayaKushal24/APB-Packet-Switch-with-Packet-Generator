# Variables
TEST    ?= reg_test

# Include paths for sub-folders
INCDIR  := +incdir+. +incdir+./Registers +incdir+./Sequences +incdir+../Design

# Design Files
DESIGN  := ../Design/apb_pkt_pkg.sv \
           ../Design/pkt_generator.sv \
           ../Design/pkt_switch.sv \
           ../Design/apb_pkt_switch.sv

# Testbench Files
TB_FILES := ./apb_if.sv \
            ./package_ral_pkt.sv \
            ./package_ral_seq.sv \
            ./tb_pkg.sv \
            ./tb_top.sv

# VCS Flags
VCS_FLAGS := -full64 -sverilog -ntb_opts uvm -licqueue -debug_access+all \
             -timescale=1ns/1ps

.PHONY: compile run clean

run: compile
	./simv +UVM_TESTNAME=$(TEST) -l simulation.log

compile:
	vcs $(VCS_FLAGS) $(INCDIR) $(DESIGN) $(TB_FILES) -l compile.log

clean:
	rm -rf simv simv.daidir csrc *.log *.key *.h
	clear

