#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

$Self->{vlt} or $Self->skip("Verilator only test");

$Self->run(cmd => ["../bin/verilator_coverage",
                   "--write", "$Self->{obj_dir}/coverage.dat",
                   "t/t_vlcov_data_a.dat",
                   "t/t_vlcov_data_b.dat",
                   "t/t_vlcov_data_c.dat",
                   "t/t_vlcov_data_d.dat",
           ],
    );

# Older clib's didn't properly sort maps, but the coverage data doesn't
# really care about ordering. So avoid false failures by sorting.
$Self->run(cmd => ["sort",
                   "$Self->{obj_dir}/coverage.dat",
                   "> $Self->{obj_dir}/coverage-sort.dat",
           ],
    );

ok(files_identical("$Self->{obj_dir}/coverage-sort.dat", "t/$Self->{name}.out"));
1;
