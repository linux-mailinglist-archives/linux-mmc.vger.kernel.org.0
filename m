Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4228257853A
	for <lists+linux-mmc@lfdr.de>; Mon, 18 Jul 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiGROVd (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 18 Jul 2022 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiGROVc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 10:21:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07612D12
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 07:21:31 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o8so7234677wms.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2022 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=AGaoAZ8ml24T/xt9w0CoIyhC90I0Qb2kP2BNkK9cPslwpZfIlLPNJM/v8noaojI5vh
         SZ3KcJfcfdPhPsQNz4GTQbJ07GLpsI59cIDqpk2aJKjPqx+rGJpVn4bjCGbl9WcR33Af
         VtoVFHOsXw+5+r8l/9eiMtZo8A40OcOzN65+c6SwuEA8oExFAXkpD97ij04KJsOOnUg5
         CW+nJMd4uRVgFKgcB2tDmjdf8ck3E92FH9AHEv6GStmB+MDWCx71ZbLwzawlo0zBlFIn
         OCwIUVdNHwKGFKUVm9Pbt8223CXnlJSQ2S0/FsrKTwaUaWdV51M2kCGWnNnxqTXPWsRd
         7FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2X8HXtEcU/ZehxuPCgIPz4aOGr6MXTRGr5kvCe3jveI=;
        b=5VTW/CcZiwuDb4tmDz+rd50ph5orAXnDnbGCts59uDbpgPpvvxzNbt//3YMCOGqsQh
         QzfMvAtJkMjirlrnCcDrRFTRouVUe43NL1IVUuf6ceEBGCEn5xGua2hJjE423r21d5Qu
         7nyKm7Mh8woU9oOtEDi1B1BNtrl+m2AiDMG42MBSIlGCH6HUOZlHR+mEAOOJc9Q4tB46
         JuuQz6FQkt0v/C+gkBtY/uy9JRRpKyY4gR6EM4FmeOqzGCKE1K+IPnIhI0QQCNnCj0OV
         chu4m7etJUnuxFkax/0P6miz2zxlTjzSx3rciMrDrwhn0cSPT8VPo0/KbQzUFOcnB8M3
         qB8Q==
X-Gm-Message-State: AJIora9xw8GXhjuQFk66mecYVF+XB1ycGL2omqThUBYMEi3D6GYWIfnO
        CUEdxxtlWIeBR5PPTaEfuHRO9ijn3nn/ENybM4c=
X-Google-Smtp-Source: AGRyM1uGs36n8cDeEnmHof1GW5dOo5X2NkPaK89mdXtxiiRra1tPLDf4dsIWeeUfodGR3YrE1qCgHST1dEfttWyFjsE=
X-Received: by 2002:a05:600c:4f05:b0:3a3:18ed:6cda with SMTP id
 l5-20020a05600c4f0500b003a318ed6cdamr6707786wmq.34.1658154090462; Mon, 18 Jul
 2022 07:21:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sgtkaylama@gmail.com
Sender: tatandji59@gmail.com
Received: by 2002:a05:600c:1d14:0:0:0:0 with HTTP; Mon, 18 Jul 2022 07:21:30
 -0700 (PDT)
From:   sgtkaylama <sgtkaylama@gmail.com>
Date:   Mon, 18 Jul 2022 14:21:30 +0000
X-Google-Sender-Auth: ehddc96FDlnQ6AdDIvnUT4hPQfk
Message-ID: <CAK4FRFcNHiVuty_5_72Kfy_NdUs=mMLfTGht_q=SVeWP-rdtwQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

5L2g5aW977yM5L2g5pS25Yiw5oiR5LmL5YmN55qE5Lik5p2h5raI5oGv5LqG5ZCX77yfDQo=
