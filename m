Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19D0701DD7
	for <lists+linux-mmc@lfdr.de>; Sun, 14 May 2023 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjENOYz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 14 May 2023 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjENOYz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 May 2023 10:24:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB191FD0
        for <linux-mmc@vger.kernel.org>; Sun, 14 May 2023 07:24:54 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f00d41df22so61648995e87.1
        for <linux-mmc@vger.kernel.org>; Sun, 14 May 2023 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684074292; x=1686666292;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=NgHC4f2MqKo46VZMrtet5qhcplgTU1ZI7W90Y3AW9ptzBr6STt5ZCbFwjne59w1IQG
         97KIvb/dxAkmV/z0pB96BbTtOfR/2DYxlVgFBDQ0RbjgZ3uX5h6OwDXFWQ89/r+pcIlC
         4+Nq9mCCxN3D1hwr+p3jCeo4AierPjdXPTOdQOAKUMfD+dL8ZHfQ3zmAfCfkYJR2Ao84
         ZnMGLKgPJFqLZVxHuYbP1rGvV2UhJakmTAqXUJvV+EFU36sC5BCe9oUThXbZOfte4cI7
         ZOQSXe4593s0Zbo21VGljjaVDpzjxoelmzrtqaEaX3RnzI8/fpWSoYNMVCECIbHKimbu
         jOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684074292; x=1686666292;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ2NTFSuwbgn1shPsMG7t3f98JKsP5lqwb6cWvxUrKw=;
        b=dl8c1/xa0aIiXLVeSIMPZjWmWuIgAX4Oehc03kzO56draIQpuWFTfaEKPw/aa8dhQD
         2p4QUlrG6i309I9KapLzqGjg9l7688jmoPTz9vuseooC0IIOWuOK4pyAp5AZ0ED4C5NZ
         FtcHH6j+1tSoroTzOq80CPi1Hxfmwz9NEQRuCArnIKNDPG917KHQCLFtuXEnkUSYRUg4
         8ax8G9FdRHHBX7BOXg6n44sZ5GjExDljmy8s4ASedYFcPuVd1LjIwZyJPNqm+43rFZ4l
         VRwAxTaVcQwQKVyJXdlhoII4bD7XHQmB2ILXR7P6zsL6uP11hlKpTXijtgLutZK9TxYE
         RyWg==
X-Gm-Message-State: AC+VfDw6mMwTxGUJIMUkcI5f72Ez5hIZLVTDbTt+eJKT3W+bj+6DWrwT
        m4lB8cwDEdaOe/XxPu3SBniNzzQwaSSx9YsA64c=
X-Google-Smtp-Source: ACHHUZ4eSeQ3+azvHPfN39kawdU8Yvpp1j6KB4SiFWPV7PPGjM2jkzH0S78o5HpR8APukVwVxzr4dLeaKNpV9vlne+k=
X-Received: by 2002:a05:6512:1326:b0:4ef:d41c:f355 with SMTP id
 x38-20020a056512132600b004efd41cf355mr5941207lfu.17.1684074292285; Sun, 14
 May 2023 07:24:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:d1:b0:226:ce3b:d35e with HTTP; Sun, 14 May 2023
 07:24:51 -0700 (PDT)
Reply-To: rw7017415@gmail.com
From:   Richard Wilson <wilson1247richard@gmail.com>
Date:   Sun, 14 May 2023 14:24:51 +0000
Message-ID: <CAPMufH47u4k-0=wVkQxxt9PXYiHBXBdsA75Ce3LWNvkE6CvmKQ@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-- 
Dear
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's
Barr's Richard Wilson
