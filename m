Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D973128F3
	for <lists+linux-mmc@lfdr.de>; Mon,  8 Feb 2021 03:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBHC24 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 7 Feb 2021 21:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhBHC2z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Feb 2021 21:28:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F07C06174A
        for <linux-mmc@vger.kernel.org>; Sun,  7 Feb 2021 18:28:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s15so7000429plr.9
        for <linux-mmc@vger.kernel.org>; Sun, 07 Feb 2021 18:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMP/G93TfBHyEy6dswHxFnCQUDA5nFWzSh+xr7IDeDM=;
        b=hrF9XFc/A8scbs/IbL5fftP83OMHXVZGCGLVmskzgJayIrOJrVoaMLXPj05aBXaO9V
         pCvUuTGPSDNK+vF2yFlgYsEiBfvJGPUgDZ0J9egI0eNsb2GkdedGuPC92eFf9Ogn4uaX
         ffp5ZkYtYc8fYUpJC2NmjwkKprHSCxmQeFPUvveX4bhEt4wU5cGlOROwiwtA/zIOYdgv
         5YOvyfotOSkg4oX4OlkkBH1ck8lV9PGkkRPpVv1QUQFiGy43PiXniM6J83j1qZiYgsY7
         IcIkgRgf0686XnW0yf6yspTWfDSgupE0DhpAA5tv4mnJh6md16tD091Qwrs2s0tfW4kK
         XKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMP/G93TfBHyEy6dswHxFnCQUDA5nFWzSh+xr7IDeDM=;
        b=NfoKsu3T5iFgP/25r3bzB2VsONoO3TmHhkCT2ntLwoporx+LIYVXs/i4HDPHA8dr4V
         va7CiIFBP51vzc+cGoQ/aOFHrZMGZmse7n9E9NZBq1xmnJjBf9i8X4Vd1lgTuU+HE89N
         n3/1g9hKwRT2s4oDuww0nzQ+agtEm1IGt0XlSewRNewzlCtMSVVwCjh+DNcN6D60Fo5V
         FFdDJJ4XEC9RwMEWRngtfvFy1eUbZnwdof/1ORs7ZWypQS4z+KWLOP9kwxvInMF0tPr9
         zn0rwpecEXchxB0ngFHE0Mrxb6puWRrjLYQq8yOUXQHcEf03U0fATk7sfwy8s67C6GHL
         bNlQ==
X-Gm-Message-State: AOAM531/PgcZm1GtFBA59nI0PgEcXw4FYJyXJUtkuYUd67+XywH5sTTO
        /8bwojnciBr6gN7AZRL77Z6AqzqqmaL9G0BW
X-Google-Smtp-Source: ABdhPJyMRT5IOqH15aeC24Odtjy7W/xbvajcyQmHYKa9/6E4LsI6cKB5+KzL+cfXomNIY79JZJxr4g==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr14454918pjn.25.1612751294713;
        Sun, 07 Feb 2021 18:28:14 -0800 (PST)
Received: from wuxy20.example.com (v-162-248-93-139.unman-vds.inap-la.nfoservers.com. [162.248.93.139])
        by smtp.gmail.com with ESMTPSA id hi15sm14356130pjb.19.2021.02.07.18.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 18:28:14 -0800 (PST)
From:   Xingyu Wu <wuxy20@gmail.com>
To:     chris@printf.net, jwerner@chromium.org, gwendal@chromium.org,
        linux-mmc@vger.kernel.org
Cc:     wuxy20@lenovo.com, Xingyu Wu <wuxy20@gmail.com>
Subject: [PATCH V2 0/1] fix messy code to be printed
Date:   Mon,  8 Feb 2021 10:26:41 +0800
Message-Id: <20210208022642.7823-1-wuxy20@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear Sirs:
This patch fixes messy printing of firmware name, please help to review,
thank you very much.

Version V2 change:
Add the recipient: linux-mmc@vger.kernel.org 

Xingyu Wu (1):
  mmc-utils: fix messy code printed

 mmc_cmds.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.25.1

