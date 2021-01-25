Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29800302163
	for <lists+linux-mmc@lfdr.de>; Mon, 25 Jan 2021 05:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAYEvQ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 24 Jan 2021 23:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbhAYEvP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2021 23:51:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99CC0613D6
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 20:50:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so6859268plh.3
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 20:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1QOy2CBTli39v+zKLvkwbYlNYYcskK1HWR3qTfGjr/s=;
        b=G5WxyZUyXn2TcQ2TUWNRcJXDXSWCQkRfwFMjOzhWd2VG0x8Al9J87MMoGSZg8Zo5Kw
         JHttGPILbg1UDvjztvtFKR9QxHcJKRQ+GdPrGD+3B0IIrgffQ6Wl7S68CdBozUyvVCNW
         KASF7GF/jowIwiKDzLDjVFpb0mH17+yia19Xi+ej48Gp5tfoyeDg7rssffnwxCHGX9h0
         mPNJsUljmKd9FlunBUeh57kJjwtktU2E8+k3+QKXMom4TZRlabJNskiG/59h0WBWK/on
         hh5rtkOZq0DoJnY//4krP33/IiGcygcB/3YT7yWIbl9Kf/sEJZaDdovEwDFLrIJxk4m4
         7Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1QOy2CBTli39v+zKLvkwbYlNYYcskK1HWR3qTfGjr/s=;
        b=GdJmKr34V1o+yk9alMoqOXVSfkoks9r9wkA7b32UWI1jcPwdk2Fqxw2i+Dl4qJ7vh0
         hrHSbB5rpHXg43qiDqoWCMbDsEYO1zSBNPwePpnbCFxA+EzexaI3AKkBIgXDEoJyo4Ip
         yz6Qy0ukxkThWaMr5z2DRb6/upm5eCUl6b7vJLd/tCEGGUTP3muQYhaLiFmMxz6tsRTh
         xoFraicPiQlrME8idDx3dWSBGtAs8SCrjA5OoMlxthTF4RNIiJU3Zo2FQJZJtCnsFQRA
         i6QNDdc6Pcy8fbwryr0K0r67VDPe74rCr2gSfmFuiXeAlyxUlI5Zp9Nk+86+PoDiMFR4
         vnyA==
X-Gm-Message-State: AOAM533Ix3K7sJsyxEFLVEVGu+k5caKN7S6bzkqPE1/P35Fg+SCv0eS4
        hElZ4uID2Q9vnGu52SjO2edGf/RRUR+PjA==
X-Google-Smtp-Source: ABdhPJy9JWWDNN0mRi0G9IluzOoJiSMRJOLAXNAMVlwM18EUSiXPydwWoMS8dIEKe5strOocpzPtPg==
X-Received: by 2002:a17:90a:aa8a:: with SMTP id l10mr894891pjq.86.1611550233842;
        Sun, 24 Jan 2021 20:50:33 -0800 (PST)
Received: from gqjiang-home.profitbricks.net ([185.125.207.232])
        by smtp.gmail.com with ESMTPSA id l14sm16459423pjy.15.2021.01.24.20.50.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:50:32 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-ide@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
        hch@infradead.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V3 0/2] remove unused argument from blk_execute_rq_nowait and blk_execute_rq
Date:   Mon, 25 Jan 2021 05:49:56 +0100
Message-Id: <1611550198-17142-1-git-send-email-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

V3 changes:
1. rebase with for-5.12/block branch.
2. add Ulf's Acked-by.

V2 changes:
1. update commit header per Christoph's comment.

Hi Jens,

This series remove unused 'q' from blk_execute_rq_nowait and blk_execute_rq.
Also update the comment for blk_execute_rq_nowait.

Thanks,
Guoqing

Guoqing Jiang (2):
  block: remove unnecessary argument from blk_execute_rq_nowait
  block: remove unnecessary argument from blk_execute_rq

 block/blk-exec.c                   | 13 +++++--------
 block/bsg.c                        |  2 +-
 block/scsi_ioctl.c                 |  6 +++---
 drivers/block/mtip32xx/mtip32xx.c  |  2 +-
 drivers/block/paride/pd.c          |  2 +-
 drivers/block/pktcdvd.c            |  2 +-
 drivers/block/sx8.c                |  4 ++--
 drivers/block/virtio_blk.c         |  2 +-
 drivers/cdrom/cdrom.c              |  2 +-
 drivers/ide/ide-atapi.c            |  2 +-
 drivers/ide/ide-cd.c               |  2 +-
 drivers/ide/ide-cd_ioctl.c         |  2 +-
 drivers/ide/ide-devsets.c          |  2 +-
 drivers/ide/ide-disk.c             |  2 +-
 drivers/ide/ide-ioctls.c           |  4 ++--
 drivers/ide/ide-park.c             |  2 +-
 drivers/ide/ide-pm.c               |  4 ++--
 drivers/ide/ide-tape.c             |  2 +-
 drivers/ide/ide-taskfile.c         |  2 +-
 drivers/mmc/core/block.c           | 10 +++++-----
 drivers/nvme/host/core.c           |  8 ++++----
 drivers/nvme/host/lightnvm.c       |  4 ++--
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/scsi_lib.c            |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 fs/nfsd/blocklayout.c              |  2 +-
 include/linux/blkdev.h             |  5 ++---
 31 files changed, 50 insertions(+), 56 deletions(-)

-- 
2.7.4

