Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D5613AC0
	for <lists+linux-mmc@lfdr.de>; Mon, 31 Oct 2022 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiJaPya (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 31 Oct 2022 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiJaPy3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2022 11:54:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B812610
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2022 08:54:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f5so8969278ejc.5
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2022 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54IXG2FPqhGXRhjbMJeBZJCoE2PKYVWz3wVMDeZTLCU=;
        b=ggQuzJDmtFt6ASf4MAUPpLpVRWq6C7d6tt/xb2JvHAUqilqDuKCKdgzoD+ZHtcZ4fq
         1eGGH4GCkwFmv29dMVSA+sfIupMAQoPy3Udm0shqfwmjwPGRMgse5DloY6LJ1rN88fY5
         7w6hrxuUesvdnXYoKXWNpBj8Pr4Xr8VccPz4cuzn5bfujDLgEBPPC3xuLT0jbsm1ipxh
         FUhqBkZXPIIrWP2PsdxLUGOhzhmQjhACQa60SJn3FJ739vynVm2k1qMYY8Csfsj0y2lM
         nw2YA5xx80yJfSa/JhPpfgs1o84qgLa+OLcJIGH+THHb6qZkx3Z3XMPBiJeb5RsMIDTj
         0+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54IXG2FPqhGXRhjbMJeBZJCoE2PKYVWz3wVMDeZTLCU=;
        b=YWuWVxv1RSWKA0ypt0dSbm4JxqJ34j6HlOOVKAc1aXSzT2uATWvFzAG90oBuSsrD8W
         Ul6OhutY+UoRZbVQs4rBXDjljtYmom2CI/0mtLMgXXURlBVNzPJk7Df4GJGrBYkC6xuK
         HkyiA8K68P3yVXkdKAYyTMcy+F1xjhh7AavGgb/FbVYgfR8ourUlqBJCze/QVUQD5E/n
         U22JvvaUmNNSkybdZxXyJomvV7Bm+jkmPgyRYEfaRIeqM/0KjBa0vE4kQV3fydfH2IgH
         AMGVE0c+0VLC8V03xeL9/6VLIVKbkXXxQ3iXpi8zgf4zFPVBA7sCkk/TjdXOR6Y7HoNj
         4VtA==
X-Gm-Message-State: ACrzQf2XWBbde9yCE8xH4wXUGUm7wBlKFzttddMsZQGO/MqE9C0VnbFB
        ZBzuQ5LZe/ljweF5d9tjSpzc9MBtoVxgDPfD+wM=
X-Google-Smtp-Source: AMsMyM5ij4ZkrsD6JU9uNQElQEIR/nCACjnjtY6wVFIdrV6cBJv1SK5jJ5zr23msglTQ3T5SKFNEM5GHVkDHr+Qm+NE=
X-Received: by 2002:a17:906:3054:b0:7ad:e82b:ac23 with SMTP id
 d20-20020a170906305400b007ade82bac23mr282876ejd.235.1667231665911; Mon, 31
 Oct 2022 08:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:608b:b0:5d:5fd:eaac with HTTP; Mon, 31 Oct 2022
 08:54:25 -0700 (PDT)
Reply-To: victorinaquezon01@yahoo.com
From:   Victorina <victorinaquezon@gmail.com>
Date:   Mon, 31 Oct 2022 15:54:25 +0000
Message-ID: <CAAOoKduTk21eCti1a2TBD7guF=FZ3iOogb8zsgEqi1wEJNe+NQ@mail.gmail.com>
Subject: Good Morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-- 
I am Madam Victorina Quezon a citizen of philippine,A widow
I am  woman going through so much pain and suffer and might not walk
again if nothing is been done fast
Please  I want you to help me retrieve the only Thing I have now in a
box  which contains my jewelries and 585,000 thounsand dollars   which
 my late husband left for me which is currently in a Security company,
I have no strength to do this due to my health condition and safety
Please Keep this Confidential
I await your response
Please reply me at     victorinaquezon01@yahoo.com
So i can explain more
With love
Victorina Quezon
