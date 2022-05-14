Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B2527336
	for <lists+linux-mmc@lfdr.de>; Sat, 14 May 2022 19:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiENRFZ (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 14 May 2022 13:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiENRFY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 14 May 2022 13:05:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7318918E00
        for <linux-mmc@vger.kernel.org>; Sat, 14 May 2022 10:05:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v4so13627853ljd.10
        for <linux-mmc@vger.kernel.org>; Sat, 14 May 2022 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=zLAXOt0+g+Gz9bXUVZthS9o5V8JSghOXkCMObSfdPds=;
        b=B0SFqUBVnADfE9h2OexZ4Rv4McOkY1iYQuwP4VbeLhupfHwGinpc1HcdmDX/Ma8zNa
         1475BM9mAOjyJXBDhiwpy8M2imuGwk2XIS2V3Frdjf/6kx3uJZmwunTIDtkW+RLWIFiA
         NkoUJvsPQoIw5550rmitsvxrTpJq3H6eDVr9o2rhxb11p3HaPMknxNkMyjvb5QBvu+Tt
         DjLwlgeBimocqbO7EMTv+kjpo3NqzNoYA0TmQubflQCP9QomjR0VztarAlzUXT57WG23
         E3E7EuzVCXjp64XBBer/NZcrDFNwRp5W1TWpyp7agFp6zqtOPSchSy9nTKZw4oJqfe6q
         Fb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=zLAXOt0+g+Gz9bXUVZthS9o5V8JSghOXkCMObSfdPds=;
        b=DpjHadklOpQ6jl1LPywACQQQUQArV5NxvL8FUIDapC+RxyjnsK2pXG+FGvlrJ14h4p
         DeI9f5sAUWqvpNf6zR3xS49Q5MK0OsAm4lQ38zYpWzrsM9wlY/jrDHcWhFlQ2KrbjUTw
         co3mGP1Kb+CmcPZ74XiG7GPwv04cstod55Iq5B6EVgrXmBjDAFM7tpcsPOmfGOKVY3wj
         KRGssxh7NbxlkQmbO+SkqYjovXfNIohyeLHasEYrDJtI+tONgjdHn9EDrkdDgO+L11OY
         ZkwzhUujvq7hYAn/+elNUvBHgV50NwCg4NKMcC/wb49bYgi/thjcfIy4C0k+9C/HOUEX
         qZ/w==
X-Gm-Message-State: AOAM532D5VrqcjOYUeFMFq5unDKMFMXVhe/zNUgyroIBzyCmLCmtLnUX
        A7MaM8KdLlgMWxnzOZzFzxM2EWXWZMk7bj9+Yr0=
X-Google-Smtp-Source: ABdhPJwEBxHO5LIb+gjzgj5mMPK+Gs8t3x1B3hu2NhQ7/TZqTsmhYnWOMhbgOmeYp24Qab4sBpmJscWXPltaSoc1eR4=
X-Received: by 2002:a2e:8657:0:b0:24f:14b6:4556 with SMTP id
 i23-20020a2e8657000000b0024f14b64556mr6203727ljj.369.1652547921515; Sat, 14
 May 2022 10:05:21 -0700 (PDT)
MIME-Version: 1.0
Sender: richardmuskus2019@gmail.com
Received: by 2002:a05:651c:a08:0:0:0:0 with HTTP; Sat, 14 May 2022 10:05:20
 -0700 (PDT)
From:   Mathew Bowles <mathewbowles2021@gmail.com>
Date:   Sat, 14 May 2022 17:05:20 +0000
X-Google-Sender-Auth: pNKbyBT06vqeGPU0WTK7-ThD5o8
Message-ID: <CAADdohk1btSxZG+pDujCzc=s7UT7QD8yPi2jsdTaKFQP-Ysz9A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello, I need your assistance in this very matter
