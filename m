Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8F54F659
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Jun 2022 13:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381381AbiFQLIs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Jun 2022 07:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382436AbiFQLIn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2022 07:08:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03CC527C8
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2022 04:08:41 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d19so4348597lji.10
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2022 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=QhDPAyBEgjG30ZNB1QG+5KscXu+11jNBtoMAgRiCaIk=;
        b=hMzceDYPGDCcx/LczfTUsb20SiC8sxngRLruiS4k3FP1TJibE7WSrgHHWo7kkr58os
         JmTTwCngBWXXsFbKHKs2LQXFuUHUmwFFsBr8WZBJ5fpXeVxojusMoKBQG/SEMHN+CHmk
         kXZCcp8EA0O1jKfWikFTiAbPAyFhs2aVmAq4tl6Tk2WEJLJnRVmu7ti54dvYUUgUBobg
         eMtAInMrjhSPFYLE3ykIrYmLu+u0T14/rMuiRfzyA71XnoM6rnqTf5RRVKK3qzoqleEa
         LBT6UeKmzBXtSIHEzHaiHGgj/n9G3dEIv7xFMxaQPUiGGx7/H8WL+4e5oH+ZbYexgWDj
         tlUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=QhDPAyBEgjG30ZNB1QG+5KscXu+11jNBtoMAgRiCaIk=;
        b=2Iep89abnbcWQq7jAq7fWZKyMAPye8Nec4bpKLWQdn2f/EOdkbrpbXWMFCNEt2BGIq
         98zv4um1gXMsacH+T3bCaTzEguvYelFqq0ZgcF57iBjsKjOx/LQGmHziTzM5hOMj6FgB
         M/Jy2dU9QBSEM4F5uYAqu6Cx+SlnOgvXQPnQcHJgVkkQtlJ6fVC3LU0QXOney98NRCit
         6RECxmehdwq15QjorQ4w2yzlMOcjFLEWUebD7ifYkfqY9aPXsjRR7Bvyqyfuj6WuWTdW
         cchoSHDgQqMrQMuJ/eD/kO0ub7n1iSqrw2qEqJYfehX6vcfAeOMpq9w36TDt1uf16YtU
         6/4g==
X-Gm-Message-State: AJIora+xJJ18SKpeNHDpTFz5VvGQQ3SQIwNbC5pN/tGpTwMJNjDh4mI2
        v5pXv22ozuLJ+MN3Mv1ja0o1iCewPEdM8lp0Kmk=
X-Google-Smtp-Source: AGRyM1ugQiLrlsQAi0RMBq73O5rxac4EWqVr62t7OQl+a9pWxg1vT+nqTncNtp/GmNlwWh5g0hVZ6jHF84Z5zDcZnX8=
X-Received: by 2002:a2e:b168:0:b0:255:b134:99d9 with SMTP id
 a8-20020a2eb168000000b00255b13499d9mr4844496ljm.64.1655464120265; Fri, 17 Jun
 2022 04:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:08:39
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:08:39 -0700
Message-ID: <CACKGxpyWtNL=ArjKsmYxS0sTXA1iyMwGSjVCwya-wE0mkQVFyA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Hi   are you available to  speak now  Thanks
