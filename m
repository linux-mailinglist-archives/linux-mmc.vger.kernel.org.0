Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD384BF7AC
	for <lists+linux-mmc@lfdr.de>; Thu, 26 Sep 2019 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfIZRij (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 Sep 2019 13:38:39 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:37316 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZRij (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2019 13:38:39 -0400
Received: by mail-qk1-f178.google.com with SMTP id u184so2507722qkd.4
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2019 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YFG6TczL/4x1QuQeJGNpaC1iKvQCR1RuKGaulOHWFkA=;
        b=Z23RywyAD28BnGpjOfRo3tkSgYwjBhNdoUXhHeCsH9ZHnWxbUAMA+tJIcn4ECXwGPg
         Oxy9nRIt2DzTfL2ToxFfg/ruBIZUD03hm+4BZsXzKryhoLikyx42rQcrrrRfeJbwDhL2
         56jc324O0zOmguIbK7lDeCPejv4obr9FC3F+qUJSHUqd0FBy+bZxHxY32iO/IjuvjR0L
         oZx4k0qTxRC5Si2ah3eC4l+fvmZr5+n+owSRjCVSVqrWWWDd44oa1mq6Hcx8ikRPRCxj
         xyE18YGtzwTTvnuYRiwJjxlbOmIaulqfjb0iLhze/ze8zn3BZT+8NVfS3JgESQ7NhocM
         UzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YFG6TczL/4x1QuQeJGNpaC1iKvQCR1RuKGaulOHWFkA=;
        b=QcE+FQHabjdK8iyakW2PmGocCfhgBd6yt4X5GS+qDts8M4XteQwzz5C7t7+XDt/eLO
         7dCPWSULAyjiqmsrn7mJ0ln3pdYx4eS3Xm5krs0URSRgGy9ol0QHynLOKhvhktbC8Lck
         kjXQtMeuOo711wmKeIrgzux7EOmXR8bTZUf0g8eQ9IhzNUHD5Ft3Sc6DOtNIln7yeTJG
         Cbmvs6BIObvvDhXiLkdB/ckbBUrFrnxxzn99gIOBa+Rl/Ldb0DpSEzwvq3lWx4nL7UIO
         5b/suQRfP0En+GuJC2e0h3d/cDJaqyBWOQLDp0BHv5VgrbP8bfE3RLO/a6gOJXjhuOiG
         uY7g==
X-Gm-Message-State: APjAAAXx+6vLHDqsZO5hPuj21FdEzFqnvWWP1rFh2Zxy2+Wf+rV8Me3/
        gp0AVS5YBhDo2AXr5rluR1EH3peDIhpcFzRA7Q0=
X-Google-Smtp-Source: APXvYqwWBlDrVsdRsARr/PU2vOknSAyue9TsuRb0tw3n/73Sl4tylJAvYcX7RtKA2q2nZ8jhowdK2PL6eLNJ7aabyV8=
X-Received: by 2002:a37:985:: with SMTP id 127mr4534321qkj.43.1569519518184;
 Thu, 26 Sep 2019 10:38:38 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Thu, 26 Sep 2019 13:38:26 -0400
Message-ID: <CAD56B7eTM-KKUMoGwwKnEz2G1Ug5oh3vG4vwPiwdrvJua9Sj3Q@mail.gmail.com>
Subject: mmc: Timeout waiting for hardware interrupt
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi All,

Every once in awhile I get this "Timeout waiting for hardware
interrupt" error. This is with a uSD on a zynq ultrascale board
running a 5.2.10-rt5 kernel (PREEMPT RT is enabled). The device tree
entries are:
/* SD1 with level shifter */
&sdhci1 {
    status = "okay";
    no-1-8-v;    /* for 1.0 silicon */
    wp-inverted;
    xlnx,mio_bank = <1>;
};
and
sdhci1: mmc@ff170000 {
    compatible = "arasan,sdhci-8.9a";
    status = "disabled";
    interrupt-parent = <&gic>;
    interrupts = <0 49 4>;
    reg = <0x0 0xff170000 0x0 0x1000>;
    clock-names = "clk_xin", "clk_ahb";
};

Maybe someone sees something.

thanks,
Paul

# [ 4764.611187] 003: mmc0: Timeout waiting for hardware interrupt.
[ 4764.611195] 003: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 4764.611199] 003: mmc0: sdhci: Sys addr:  0x00000020 | Version:  0x00001002
[ 4764.611202] 003: mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000020
[ 4764.611205] 003: mmc0: sdhci: Argument:  0x00d83150 | Trn mode: 0x0000003b
[ 4764.611209] 003: mmc0: sdhci: Present:   0x1ff70206 | Host ctl: 0x0000003d
[ 4764.611212] 003: mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 4764.611215] 003: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
[ 4764.611218] 003: mmc0: sdhci: Timeout:   0x00000006 | Int stat: 0x00000000
[ 4764.611221] 003: mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
[ 4764.611224] 003: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[ 4764.611227] 003: mmc0: sdhci: Caps:      0x75ec3281 | Caps_1:   0x00002007
[ 4764.611230] 003: mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[ 4764.611233] 003: mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[ 4764.611236] 003: mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00000900
[ 4764.611239] 003: mmc0: sdhci: Host ctl2: 0x00000000
[ 4764.611242] 003: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
0x0000000070048200
[ 4764.611245] 003: mmc0: sdhci: ============================================
[ 4764.711249] 003: mmc0: Reset 0x2 never completed.
[ 4764.711252] 003: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 4764.711254] 003: mmc0: sdhci: Sys addr:  0x00000020 | Version:  0x00001002
[ 4764.711257] 003: mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000020
[ 4764.711260] 003: mmc0: sdhci: Argument:  0x00d83150 | Trn mode: 0x0000003b
[ 4764.711263] 003: mmc0: sdhci: Present:   0x1ff70206 | Host ctl: 0x0000003d
[ 4764.711266] 003: mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 4764.711269] 003: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
[ 4764.711272] 003: mmc0: sdhci: Timeout:   0x00000006 | Int stat: 0x00000000
[ 4764.711275] 003: mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
[ 4764.711278] 003: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[ 4764.711281] 003: mmc0: sdhci: Caps:      0x75ec3281 | Caps_1:   0x00002007
[ 4764.711284] 003: mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[ 4764.711287] 003: mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[ 4764.711290] 003: mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00000900
[ 4764.711292] 003: mmc0: sdhci: Host ctl2: 0x00000000
[ 4764.711295] 003: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
0x0000000070048200
[ 4764.711298] 003: mmc0: sdhci: ============================================
[ 4764.811302] 003: mmc0: Reset 0x4 never completed.
[ 4764.811304] 003: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[ 4764.811307] 003: mmc0: sdhci: Sys addr:  0x00000020 | Version:  0x00001002
[ 4764.811309] 003: mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000020
[ 4764.811312] 003: mmc0: sdhci: Argument:  0x00d83150 | Trn mode: 0x0000003b
[ 4764.811315] 003: mmc0: sdhci: Present:   0x1ff70206 | Host ctl: 0x0000003d
[ 4764.811318] 003: mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
[ 4764.811321] 003: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000207
[ 4764.811323] 003: mmc0: sdhci: Timeout:   0x00000006 | Int stat: 0x00000000
[ 4764.811326] 003: mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
[ 4764.811329] 003: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[ 4764.811331] 003: mmc0: sdhci: Caps:      0x75ec3281 | Caps_1:   0x00002007
[ 4764.811334] 003: mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
[ 4764.811337] 003: mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
[ 4764.811340] 003: mmc0: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00000900
[ 4764.811342] 003: mmc0: sdhci: Host ctl2: 0x00000000
[ 4764.811345] 003: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr:
0x0000000070048200
[ 4764.811347] 003: mmc0: sdhci: ============================================
[ 4772.035195] 002: INFO: task kworker/0:2H:1027 blocked for more than
10 seconds.
[ 4772.035202] 002:       Tainted: G         C
5.2.10-rt5-00011-g2b6ca6e3766b-dirty #64
[ 4772.035205] 002: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 4772.035209] 002: kworker/0:2H    D    0  1027      2 0x00000028
[ 4772.035232] 002: Workqueue: kblockd blk_mq_run_work_fn
[ 4772.035235] 002: Call trace:
[ 4772.035237] 002: __switch_to (arch/arm64/kernel/process.c:514)
[ 4772.035244] 002: __schedule (kernel/sched/core.c:2962
kernel/sched/core.c:3587)
[ 4772.035251] 002: schedule (kernel/sched/core.c:3655 (discriminator 1))
[ 4772.035255] 002: mmc_blk_rw_wait (drivers/mmc/core/block.c:2160
(discriminator 8))
[ 4772.035261] 002: mmc_blk_mq_issue_rq (drivers/mmc/core/block.c:2182
drivers/mmc/core/block.c:2261)
[ 4772.035265] 002: mmc_mq_queue_rq (drivers/mmc/core/queue.c:313)
[ 4772.035269] 002: blk_mq_dispatch_rq_list (block/blk-mq.c:1271)
[ 4772.035274] 002: blk_mq_do_dispatch_sched (block/blk-mq-sched.c:115)
[ 4772.035279] 002: blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:211)
[ 4772.035283] 002: __blk_mq_run_hw_queue (block/blk-mq.c:1402
(discriminator 3))
[ 4772.035287] 002: blk_mq_run_work_fn (block/blk-mq.c:1635)
[ 4772.035291] 002: process_one_work (./include/linux/compiler.h:194
./include/asm-generic/atomic-instrumented.h:27
./include/linux/jump_label.h:251 ./include/linux/jump_label.h:261
./include/trace/events/workqueue.h:114 kernel/workqueue.c:2277)
[ 4772.035296] 002: worker_thread (./include/linux/compiler.h:194
./include/linux/list.h:254 kernel/workqueue.c:2419)
[ 4772.035300] 002: kthread (kernel/kthread.c:255)
[ 4772.035305] 002: ret_from_fork (arch/arm64/kernel/entry.S:1174)
[ 4774.851130] 003: mmc0: Timeout waiting for hardware interrupt.
