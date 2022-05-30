Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FE5385D7
	for <lists+linux-mmc@lfdr.de>; Mon, 30 May 2022 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiE3QHO (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 30 May 2022 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiE3QHN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2022 12:07:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAB579BF
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 09:07:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bf44so1893346lfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2022 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=s7095fKF5kyad6EgVhyo3ZHYESRpknTbw0cpB1kzGkw=;
        b=AxYl/sTFiUymHH5ZF75PwgFT1HMD0iflH08sXbFIJ/Qg+YrdtHMItNmDP9YdfStkJa
         jyeLtv+ro0x/+IRAhyZhlh284JyOzeJSc58x5H+CIsvm2qKl2KwNuGS3gjnV/8t6SNO8
         6IL9TqxOCzIun72T1TNv+44g5OMdgo3se8E1FBxDBkPnVdDASoO1gaixRe5vM49FOuqu
         Lz1EDmFCOMznQ3j0W7ayx/WngXMf8kkbquTqgr7QYsTkVA9UtumtkOta296BvNffHhRI
         VemD5r2hAS1IyhifdmZMWOEJbi7/k2+EYEB7tTIgztfP0YXDs9YsgDeUFBcpdj2pk9uE
         stMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=s7095fKF5kyad6EgVhyo3ZHYESRpknTbw0cpB1kzGkw=;
        b=6IodqoAy5oVIDvydFOkIC1UhpbFI3eYklUZrI0Ftnfz02dvuON3sZvFrKQ+iu8Rhl6
         LW2EXiulDgpnT9wgK9Gn9p0FPoaVlTi6BFWKBCeeYz6W1m6RoFtzo+9ZQp9B+WbKRd5v
         4SOY6vH2WgX73YDnxkaHKACHYU0Btc8m5ZcrlzovhXNDfj5ud8Dy3kqqqdBTydebSomw
         FgM1d+7uWdqsYMFEAS0C/sFWBYxrMdtuLgsTJ0jbvQ1bMRxZqhdonCCyQIkjfr1KhfWQ
         Z7F9Yx3aZja7FBX+ZJJaQHNGPAOQlcqEszStkPQuIRJ5YSAvQiN3L39dpoKxjTLu+ggm
         4ytQ==
X-Gm-Message-State: AOAM530VOXurm25bSk9csEG4aSicRvyjh72yKAH5oS3XwPL1+oYtRLY4
        dnFJYVCQjlRfTBjF6y8fxAHWzEv+fihmZuX68BE=
X-Google-Smtp-Source: ABdhPJwT3dRU6dH1/Fmc4bFS2wkwLBkf2LlFMgm/ULMwPnYkbAV3cJ4HAs6ALV5JRVoJAV1R63FtHBAKP4jq5Q89e48=
X-Received: by 2002:a05:6512:48e:b0:477:c024:1a1c with SMTP id
 v14-20020a056512048e00b00477c0241a1cmr41318533lfq.100.1653926827534; Mon, 30
 May 2022 09:07:07 -0700 (PDT)
MIME-Version: 1.0
Sender: kamianthonylw@gmail.com
Received: by 2002:a05:6520:244a:b0:1d0:556f:f332 with HTTP; Mon, 30 May 2022
 09:07:06 -0700 (PDT)
From:   Charles Renata <advocatecharlesranata.chembers@gmail.com>
Date:   Mon, 30 May 2022 16:07:06 +0000
X-Google-Sender-Auth: WB_odcvxjkaNiTw-9ZVR6k0C8Wo
Message-ID: <CANVCc0Aord61i1igSZ+eat6uPViftQfDnGi5u6O9jNGj7u87Sw@mail.gmail.com>
Subject: Warm wishes,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Warm Wishes.

I am barrister Charles Renata, I am contacting you again to confirm if
you have received my previous email regarding my late client's
estimated inheritance of ($13.6 Million USD). I am writing to you
because you have the same surname as my late client.

Respond for further information
Sincerely,
Charles Renata (lawyer)
